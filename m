Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE161C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D46C22459
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="qZSSo6s3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D46C22459
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932886AbeGFWGa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 18:06:30 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:28354 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754316AbeGFWGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 18:06:14 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 5EE1F592;
        Sat,  7 Jul 2018 00:06:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1530914766; x=1532729167; bh=iuCJ91Ohx1Uj+moWp+9nDH1WpAqQWJVq/bH
        fq4/Xvw0=; b=qZSSo6s3EXKLySNNhg9DTW/Llx9xGWsURQqw0ztwGElpCcsB7lZ
        PbYU43nhgvwLAXEmvbkHpmzbOXXaIokhERDksXSIbIG4PjH0yQJmvDLdm5hIRL/h
        wx8Vw0Z7uack0WuHd8Sqe/SzadOGJ81jTtdh9bctbU5FwlreQnxEc8acPeh7vY2r
        aZeUsWzpXCC4Cq7BqDUkL6Q+xmdVJ0vPVGv7y/o/n+XdkC56eCzjxzbxX2Ixb1eG
        X+ph/cTxstmb5Kk+Anf7fkO4Sqmm1B/PLH9/dETufPW264mLGP76uGYq7Lndj5cg
        n/m1FCZ+5DbdBmosMCdC9IoXW/TGxMG1W5C8/z9I5e6tMigQT5v1SDi87Du9L7hG
        E22cmtqMq3RBL7w0Hlwea6KuuDHA38X9MYJwtPg4LNh1TVjK7r6yg6GMnr2Vw5N1
        WLaM0F4l+4b7ZmfHudaUm6u4R4oeWa/7ZtSvZv7w55aPEeS6mQKJY++omuv5uNxP
        p//+QEk2Q6hjPM1fZbajacpzpKB2Etru7eSAMdKQDVxP0UblfkAYuW+RomDSGgPZ
        mLAM0WlG9HmHRtjaWW+vP06TtyR/wgZy5V8xmdU/8Yx8hT2eKMyNrDaWSU2HAgUa
        5kZa8x0K02avyZXP+7nq2PiYXfAHcXnD6dbwxi104WSgmD7hOkRgYf64=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id f6iMwf3MGlWa; Sat,  7 Jul 2018 00:06:06 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 8451F569;
        Sat,  7 Jul 2018 00:06:06 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 239BD345;
        Sat,  7 Jul 2018 00:06:06 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alessia Mantegazza <amantegazza@vaga.pv.it>,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH 2/2] doc:it_IT: translation for kernel-hacking
Date:   Sat,  7 Jul 2018 00:05:17 +0200
Message-Id: <20180706220517.28623-3-federico.vaga@vaga.pv.it>
In-Reply-To: <20180706220517.28623-1-federico.vaga@vaga.pv.it>
References: <20180706220517.28623-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes the kernel-hacking translation in Italian (both
hacking.rst and locking.rst).

It adds also the anchors for the english kernel-hacking documents.

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/kernel-hacking/hacking.rst      |    2 +
 Documentation/kernel-hacking/locking.rst      |    2 +
 Documentation/translations/it_IT/index.rst    |    1 +
 .../it_IT/kernel-hacking/hacking.rst          |  855 ++++++++++
 .../it_IT/kernel-hacking/index.rst            |   16 +
 .../it_IT/kernel-hacking/locking.rst          | 1493 +++++++++++++++++
 6 files changed, 2369 insertions(+)
 create mode 100644 Documentation/translations/it_IT/kernel-hacking/hacking.rst
 create mode 100644 Documentation/translations/it_IT/kernel-hacking/index.rst
 create mode 100644 Documentation/translations/it_IT/kernel-hacking/locking.rst

diff --git a/Documentation/kernel-hacking/hacking.rst b/Documentation/kernel-hacking/hacking.rst
index 9999c8468293..d824e4feaff3 100644
--- a/Documentation/kernel-hacking/hacking.rst
+++ b/Documentation/kernel-hacking/hacking.rst
@@ -1,3 +1,5 @@
+.. _kernel_hacking_hack:
+
 ============================================
 Unreliable Guide To Hacking The Linux Kernel
 ============================================
diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-hacking/locking.rst
index 574fc92a6f20..9cd3bc1c3491 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -1,3 +1,5 @@
+.. _kernel_hacking_lock:
+
 ===========================
 Unreliable Guide To Locking
 ===========================
diff --git a/Documentation/translations/it_IT/index.rst b/Documentation/translations/it_IT/index.rst
index dae01886b073..898a7823a6f4 100644
--- a/Documentation/translations/it_IT/index.rst
+++ b/Documentation/translations/it_IT/index.rst
@@ -87,6 +87,7 @@ vostre modifiche molto più semplice
    :maxdepth: 2
 
    doc-guide/index
+   kernel-hacking/index
 
 .. warning::
 
diff --git a/Documentation/translations/it_IT/kernel-hacking/hacking.rst b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
new file mode 100644
index 000000000000..7178e517af0a
--- /dev/null
+++ b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
@@ -0,0 +1,855 @@
+.. include:: ../disclaimer-ita.rst
+
+.. note:: Per leggere la documentazione originale in inglese:
+	  :ref:`Documentation/kernel-hacking/hacking.rst <kernel_hacking_hack>`
+
+:Original: :ref:`Documentation/kernel-hacking/hacking.rst <kernel_hacking_hack>`
+:Translator: Federico Vaga <federico.vaga@vaga.pv.it>
+
+.. _it_kernel_hacking_hack:
+
+=================================================
+L'inaffidabile guida all'hacking del kernel Linux
+=================================================
+
+:Author: Rusty Russell
+
+Introduzione
+============
+
+Benvenuto, gentile lettore, alla notevole ed inaffidabile guida all'hacking
+del kernel Linux ad opera di Rusty. Questo documento descrive le procedure
+più usate ed i concetti necessari per scrivere codice per il kernel: lo scopo
+è di fornire ai programmatori C più esperti un manuale di base per sviluppo.
+Eviterò dettagli implementativi: per questo abbiamo il codice,
+ed ignorerò intere parti di alcune procedure.
+
+Prima di leggere questa guida, sappiate che non ho mai voluto scriverla,
+essendo esageratamente sotto qualificato, ma ho sempre voluto leggere
+qualcosa di simile, e quindi questa era l'unica via. Spero che possa
+crescere e diventare un compendio di buone pratiche, punti di partenza
+e generiche informazioni.
+
+Gli attori
+==========
+
+In qualsiasi momento ognuna delle CPU di un sistema può essere:
+
+-  non associata ad alcun processo, servendo un'interruzione hardware;
+
+-  non associata ad alcun processo, servendo un softirq o tasklet;
+
+-  in esecuzione nello spazio kernel, associata ad un processo
+   (contesto utente);
+
+-  in esecuzione di un processo nello spazio utente;
+
+Esiste un ordine fra questi casi. Gli ultimi due possono avvicendarsi (preempt)
+l'un l'altro, ma a parte questo esiste una gerarchia rigida: ognuno di questi
+può avvicendarsi solo ad uno di quelli sottostanti. Per esempio, mentre un
+softirq è in esecuzione su d'una CPU, nessun altro softirq può avvicendarsi
+nell'esecuzione, ma un'interruzione hardware può. Ciò nonostante, le altre CPU
+del sistema operano indipendentemente.
+
+Più avanti vedremo alcuni modi in cui dal contesto utente è possibile bloccare
+le interruzioni, così da impedirne davvero il diritto di prelazione.
+
+Contesto utente
+---------------
+
+Ci si trova nel contesto utente quando si arriva da una chiamata di sistema
+od altre eccezioni: come nello spazio utente, altre procedure più importanti,
+o le interruzioni, possono far valere il proprio diritto di prelazione sul
+vostro processo. Potete sospendere l'esecuzione chiamando :c:func:`schedule()`.
+
+.. note::
+
+    Si è sempre in contesto utente quando un modulo viene caricato o rimosso,
+    e durante le operazioni nello strato dei dispositivi a blocchi
+    (*block layer*).
+
+Nel contesto utente, il puntatore ``current`` (il quale indica il processo al
+momento in esecuzione) è valido, e :c:func:`in_interrupt()`
+(``include/linux/preempt.h``) è falsa.
+
+.. warning::
+
+    Attenzione che se avete la prelazione o i softirq disabilitati (vedere
+    di seguito), :c:func:`in_interrupt()` ritornerà un falso positivo.
+
+Interruzioni hardware (Hard IRQs)
+---------------------------------
+
+Temporizzatori, schede di rete e tastiere sono esempi di vero hardware
+che possono produrre interruzioni in un qualsiasi momento. Il kernel esegue
+i gestori d'interruzione che prestano un servizio all'hardware. Il kernel
+garantisce che questi gestori non vengano mai interrotti: se una stessa
+interruzione arriva, questa verrà accodata (o scartata).
+Dato che durante la loro esecuzione le interruzioni vengono disabilitate,
+i gestori d'interruzioni devono essere veloci: spesso si limitano
+esclusivamente a notificare la presa in carico dell'interruzione,
+programmare una 'interruzione software' per l'esecuzione e quindi terminare.
+
+Potete dire d'essere in una interruzione hardware perché :c:func:`in_irq()`
+ritorna vero.
+
+.. warning::
+
+    Attenzione, questa ritornerà un falso positivo se le interruzioni
+    sono disabilitate (vedere di seguito).
+
+Contesto d'interruzione software: softirq e tasklet
+---------------------------------------------------
+
+Quando una chiamata di sistema sta per tornare allo spazio utente,
+oppure un gestore d'interruzioni termina, qualsiasi 'interruzione software'
+marcata come pendente (solitamente da un'interruzione hardware) viene
+eseguita (``kernel/softirq.c``).
+
+La maggior parte del lavoro utile alla gestione di un'interruzione avviene qui.
+All'inizio della transizione ai sistemi multiprocessore, c'erano solo i
+cosiddetti 'bottom half' (BH), i quali non traevano alcun vantaggio da questi
+sistemi. Non appena abbandonammo i computer raffazzonati con fiammiferi e
+cicche, abbandonammo anche questa limitazione e migrammo alle interruzioni
+software 'softirqs'.
+
+Il file ``include/linux/interrupt.h`` elenca i differenti tipi di 'softirq'.
+Un tipo di softirq molto importante è il timer (``include/linux/timer.h``):
+potete programmarlo per far si che esegua funzioni dopo un determinato
+periodo di tempo.
+
+Dato che i softirq possono essere eseguiti simultaneamente su più di un
+processore, spesso diventa estenuante l'averci a che fare. Per questa ragione,
+i tasklet (``include/linux/interrupt.h``) vengo usati più di frequente:
+possono essere registrati dinamicamente (il che significa che potete averne
+quanti ne volete), e garantiscono che un qualsiasi tasklet verrà eseguito
+solo su un processore alla volta, sebbene diversi tasklet possono essere
+eseguiti simultaneamente.
+
+.. warning::
+
+    Il nome 'tasklet' è ingannevole: non hanno niente a che fare
+    con i 'processi' ('tasks'), e probabilmente hanno più a che vedere
+    con qualche pessima vodka che Alexey Kuznetsov si fece a quel tempo.
+
+Potete determinate se siete in un softirq (o tasklet) utilizzando la
+macro :c:func:`in_softirq()` (``include/linux/preempt.h``).
+
+.. warning::
+
+    State attenti che questa macro ritornerà un falso positivo
+    se :ref:`botton half lock <it_local_bh_disable>` è bloccato.
+
+Alcune regole basilari
+======================
+
+Nessuna protezione della memoria
+    Se corrompete la memoria, che sia in contesto utente o d'interruzione,
+    la macchina si pianterà. Siete sicuri che quello che volete fare
+    non possa essere fatto nello spazio utente?
+
+Nessun numero in virgola mobile o MMX
+    Il contesto della FPU non è salvato; anche se siete in contesto utente
+    lo stato dell'FPU probabilmente non corrisponde a quello del processo
+    corrente: vi incasinerete con lo stato di qualche altro processo. Se
+    volete davvero usare la virgola mobile, allora dovrete salvare e recuperare
+    lo stato dell'FPU (ed evitare cambi di contesto). Generalmente è una
+    cattiva idea; usate l'aritmetica a virgola fissa.
+
+Un limite rigido dello stack
+    A seconda della configurazione del kernel lo stack è fra 3K e 6K per la
+    maggior parte delle architetture a 32-bit; è di 14K per la maggior
+    parte di quelle a 64-bit; e spesso è condiviso con le interruzioni,
+    per cui non si può usare.
+    Evitare profonde ricorsioni ad enormi array locali nello stack
+    (allocateli dinamicamente).
+
+Il kernel Linux è portabile
+    Quindi mantenetelo tale. Il vostro codice dovrebbe essere a 64-bit ed
+    indipendente dall'ordine dei byte (endianess) di un processore. Inoltre,
+    dovreste minimizzare il codice specifico per un processore; per esempio
+    il codice assembly dovrebbe essere incapsulato in modo pulito e minimizzato
+    per facilitarne la migrazione. Generalmente questo codice dovrebbe essere
+    limitato alla parte di kernel specifica per un'architettura.
+
+ioctl: non scrivere nuove chiamate di sistema
+=============================================
+
+Una chiamata di sistema, generalmente, è scritta così::
+
+    asmlinkage long sys_mycall(int arg)
+    {
+            return 0;
+    }
+
+Primo, nella maggior parte dei casi non volete creare nuove chiamate di
+sistema.
+Create un dispositivo a caratteri ed implementate l'appropriata chiamata ioctl.
+Questo meccanismo è molto più flessibile delle chiamate di sistema: esso non
+dev'essere dichiarato in tutte le architetture nei file
+``include/asm/unistd.h`` e ``arch/kernel/entry.S``; inoltre, è improbabile
+che questo venga accettato da Linus.
+
+Se tutto quello che il vostro codice fa è leggere o scrivere alcuni parametri,
+considerate l'implementazione di un'interfaccia :c:func:`sysfs()`.
+
+All'interno di una ioctl vi trovate nel contesto utente di un processo. Quando
+avviene un errore dovete ritornare un valore negativo di errno (consultate
+``include/uapi/asm-generic/errno-base.h``,
+``include/uapi/asm-generic/errno.h`` e ``include/linux/errno.h``), altrimenti
+ritornate 0.
+
+Dopo aver dormito dovreste verificare se ci sono stati dei segnali: il modo
+Unix/Linux di gestire un segnale è di uscire temporaneamente dalla chiamata
+di sistema con l'errore ``-ERESTARTSYS``. La chiamata di sistema ritornerà
+al contesto utente, eseguirà il gestore del segnale e poi la vostra chiamata
+di sistema riprenderà (a meno che l'utente non l'abbia disabilitata). Quindi,
+dovreste essere pronti per continuare l'esecuzione, per esempio nel mezzo
+della manipolazione di una struttura dati.
+
+::
+
+    if (signal_pending(current))
+            return -ERESTARTSYS;
+
+Se dovete eseguire dei calcoli molto lunghi: pensate allo spazio utente.
+Se **davvero** volete farlo nel kernel ricordatevi di verificare periodicamente
+se dovete *lasciare* il processore (ricordatevi che, per ogni processore, c'è
+un sistema multi-processo senza diritto di prelazione).
+Esempio::
+
+    cond_resched(); /* Will sleep */
+
+Una breve nota sulla progettazione delle interfacce: il motto dei sistemi
+UNIX è "fornite meccanismi e non politiche"
+
+La ricetta per uno stallo
+=========================
+
+Non è permesso invocare una procedura che potrebbe dormire, fanno eccezione
+i seguenti casi:
+
+-  Siete in un contesto utente.
+
+-  Non trattenete alcun spinlock.
+
+-  Avete abilitato le interruzioni (in realtà, Andy Kleen dice che
+   lo schedulatore le abiliterà per voi, ma probabilmente questo non è quello
+   che volete).
+
+Da tener presente che alcune funzioni potrebbero dormire implicitamente:
+le più comuni sono quelle per l'accesso allo spazio utente (\*_user) e
+quelle per l'allocazione della memoria senza l'opzione ``GFP_ATOMIC``
+
+Dovreste sempre compilare il kernel con l'opzione ``CONFIG_DEBUG_ATOMIC_SLEEP``
+attiva, questa vi avviserà se infrangete una di queste regole.
+Se **infrangete** le regole, allora potreste bloccare il vostro scatolotto.
+
+Veramente.
+
+Alcune delle procedure più comuni
+=================================
+
+:c:func:`printk()`
+------------------
+
+Definita in ``include/linux/printk.h``
+
+:c:func:`printk()` fornisce messaggi alla console, dmesg, e al demone syslog.
+Essa è utile per il debugging o per la notifica di errori; può essere
+utilizzata anche all'interno del contesto d'interruzione, ma usatela con
+cautela: una macchina che ha la propria console inondata da messaggi diventa
+inutilizzabile. La funzione utilizza un formato stringa quasi compatibile con
+la printf ANSI C, e la concatenazione di una stringa C come primo argomento
+per indicare la "priorità"::
+
+    printk(KERN_INFO "i = %u\n", i);
+
+Consultate ``include/linux/kern_levels.h`` per gli altri valori ``KERN_``;
+questi sono interpretati da syslog come livelli. Un caso speciale:
+per stampare un indirizzo IP usate::
+
+    __be32 ipaddress;
+    printk(KERN_INFO "my ip: %pI4\n", &ipaddress);
+
+
+:c:func:`printk()` utilizza un buffer interno di 1K e non s'accorge di
+eventuali sforamenti. Accertatevi che vi basti.
+
+.. note::
+
+    Saprete di essere un vero hacker del kernel quando inizierete a digitare
+    nei vostri programmi utenti le printf come se fossero printk :)
+
+.. note::
+
+    Un'altra nota a parte: la versione originale di Unix 6 aveva un commento
+    sopra alla funzione printf: "Printf non dovrebbe essere usata per il
+    chiacchiericcio". Dovreste seguire questo consiglio.
+
+:c:func:`copy_to_user()` / :c:func:`copy_from_user()` / :c:func:`get_user()` / :c:func:`put_user()`
+---------------------------------------------------------------------------------------------------
+
+Definite in ``include/linux/uaccess.h`` / ``asm/uaccess.h``
+
+**[DORMONO]**
+
+:c:func:`put_user()` e :c:func:`get_user()` sono usate per ricevere ed
+impostare singoli valori (come int, char, o long) da e verso lo spazio utente.
+Un puntatore nello spazio utente non dovrebbe mai essere dereferenziato: i dati
+dovrebbero essere copiati usando suddette procedure. Entrambe ritornano
+``-EFAULT`` oppure 0.
+
+:c:func:`copy_to_user()` e :c:func:`copy_from_user()` sono più generiche:
+esse copiano una quantità arbitraria di dati da e verso lo spazio utente.
+
+.. warning::
+
+    Al contrario di:c:func:`put_user()` e :c:func:`get_user()`, queste
+    funzioni ritornano la quantità di dati copiati (0 è comunque un successo).
+
+[Sì, questa stupida interfaccia mi imbarazza. La battaglia torna in auge anno
+dopo anno. --RR]
+
+Le funzioni potrebbero dormire implicitamente. Queste non dovrebbero mai essere
+invocate fuori dal contesto utente (non ha senso), con le interruzioni
+disabilitate, o con uno spinlock trattenuto.
+
+:c:func:`kmalloc()`/:c:func:`kfree()`
+-------------------------------------
+
+Definite in ``include/linux/slab.h``
+
+**[POTREBBERO DORMIRE: LEGGI SOTTO]**
+
+Queste procedure sono utilizzate per la richiesta dinamica di un puntatore ad
+un pezzo di memoria allineato, esattamente come malloc e free nello spazio
+utente, ma :c:func:`kmalloc()` ha un argomento aggiuntivo per indicare alcune
+opzioni. Le opzioni più importanti sono:
+
+``GFP_KERNEL``
+    Potrebbe dormire per librarare della memoria. L'opzione fornisce il modo
+    più affidabile per allocare memoria, ma il suo uso è strettamente limitato
+    allo spazio utente.
+
+``GFP_ATOMIC``
+    Non dorme. Meno affidabile di ``GFP_KERNEL``, ma può essere usata in un
+    contesto d'interruzione. Dovreste avere **davvero** una buona strategia
+    per la gestione degli errori in caso di mancanza di memoria.
+
+``GFP_DMA``
+    Alloca memoria per il DMA sul bus ISA nello spazio d'indirizzamento
+    inferiore ai 16MB. Se non sapete cos'è allora non vi serve.
+    Molto inaffidabile.
+
+Se vedete un messaggio d'avviso per una funzione dormiente che viene chiamata
+da un contesto errato, allora probabilmente avete usato una funzione
+d'allocazione dormiente da un contesto d'interruzione senza ``GFP_ATOMIC``.
+Dovreste correggerlo. Sbrigatevi, non cincischiate.
+
+Se allocate almeno ``PAGE_SIZE``(``asm/page.h`` o ``asm/page_types.h``) byte,
+considerate l'uso di :c:func:`__get_free_pages()` (``include/linux/gfp.h``).
+Accetta un argomento che definisce l'ordine (0 per per la dimensione di una
+pagine, 1 per una doppia pagina, 2 per quattro pagine, eccetra) e le stesse
+opzioni d'allocazione viste precedentemente.
+
+Se state allocando un numero di byte notevolemnte superiore ad una pagina
+potete usare :c:func:`vmalloc()`. Essa allocherà memoria virtuale all'interno
+dello spazio kernel. Questo è un blocco di memoria fisica non contiguo, ma
+la MMU vi darà l'impressione che lo sia (quindi, sarà contiguo solo dal punto
+di vista dei processori, non dal punto di vista dei driver dei dispositivi
+esterni).
+Se per qualche strana ragione avete davvero bisogno di una grossa quantità di
+memoria fisica contigua, avete un problema: Linux non ha un buon supporto per
+questo caso d'uso perché, dopo un po' di tempo, la frammentazione della memoria
+rende l'operazione difficile. Il modo migliore per allocare un simile blocco
+all'inizio dell'avvio del sistema è attraverso la procedura
+:c:func:`alloc_bootmem()`.
+
+Prima di inventare la vostra cache per gli oggetti più usati, considerate
+l'uso di una cache slab disponibile in ``include/linux/slab.h``.
+
+:c:func:`current()`
+-------------------
+
+Definita in ``include/asm/current.h``
+
+Questa variabile globale (in realtà una macro) contiene un puntatore alla
+struttura del processo corrente, quindi è valido solo dal contesto utente.
+Per esempio, quando un processo esegue una chiamata di sistema, questo
+punterà alla struttura dati del processo chiamate.
+Nel contesto d'interruzione in suo valore **non è NULL**.
+
+:c:func:`mdelay()`/:c:func:`udelay()`
+-------------------------------------
+
+Definite in ``include/asm/delay.h`` / ``include/linux/delay.h``
+
+Le funzioni :c:func:`udelay()` e :c:func:`ndelay()` possono essere utilizzate
+per brevi pause. Non usate grandi valori perché rischiate d'avere un
+overflow - in questo contesto la funzione :c:func:`mdelay()` è utile,
+oppure considerate :c:func:`msleep()`.
+
+:c:func:`cpu_to_be32()`/:c:func:`be32_to_cpu()`/:c:func:`cpu_to_le32()`/:c:func:`le32_to_cpu()`
+-----------------------------------------------------------------------------------------------
+
+Definite in ``include/asm/byteorder.h``
+
+La famiglia di funzioni :c:func:`cpu_to_be32()` (dove "32" può essere
+sostituito da 64 o 16, e "be" con "le") forniscono un modo generico
+per fare conversioni sull'ordine dei byte (endianess): esse ritornano
+il valore convertito. Tutte le varianti supportano anche il processo inverso:
+:c:func:`be32_to_cpu()`, eccetera.
+
+Queste funzioni hanno principalmente due varianti: la variante per
+puntatori, come :c:func:`cpu_to_be32p(), che prende un puntatore
+ad un tipo, e ritorna il valore convertito. L'altra variante per
+la famiglia di conversioni "in-situ", come :c:func:`cpu_to_be32s()`,
+che convertono il valore puntato da un puntatore, e ritornano void.
+
+:c:func:`local_irq_save()`/:c:func:`local_irq_restore()`
+--------------------------------------------------------
+
+Definite in ``include/linux/irqflags.h``
+
+Queste funzioni abilitano e disabilitano le interruzioni hardware
+sul processore locale. Entrambe sono rientranti; esse salvano lo stato
+precedente nel proprio argomento ``unsigned long flags``. Se sapete
+che le interruzioni sono abilite, potete semplicemente utilizzare
+:c:func:`local_irq_disable()` e :c:func:`local_irq_enable()`.
+
+.. _it_local_bh_disable:
+
+:c:func:`local_bh_disable()`/:c:func:`local_bh_enable()`
+--------------------------------------------------------
+
+Definite in ``include/linux/bottom_half.h``
+
+
+Queste funzioni abilitano e disabilitano le interruzioni software
+sul processore locale. Entrambe sono rientranti; se le interruzioni
+software erano già state disabilitate in precedenza, rimarranno
+disabilitate anche dopo aver invocato questa coppia di funzioni.
+Lo scopo è di prevenire l'esecuzione di softirq e tasklet sul processore
+attuale.
+
+:c:func:`smp_processor_id()`
+----------------------------
+
+Definita in ``include/linux/smp.h``
+
+:c:func:`get_cpu()` nega il diritto di prelazione (quindi non potete essere
+spostati su un altro processore all'improvviso) e ritorna il numero
+del processore attuale, fra 0 e ``NR_CPUS``. Da notare che non è detto
+che la numerazione dei processori sia continua. Quando avete terminato,
+ritornate allo stato precedente con :c:func:`put_cpu()`.
+
+Se sapete che non dovete essere interrotti da altri processi (per esempio,
+se siete in un contesto d'interruzione, o il diritto di prelazione
+è disabilitato) potete utilizzare smp_processor_id().
+
+
+``__init``/``__exit``/``__initdata``
+------------------------------------
+
+Definite in  ``include/linux/init.h``
+
+Dopo l'avvio, il kernel libera una sezione speciale; le funzioni marcate
+con ``__init`` e le strutture dati marcate con ``__initdata`` vengono
+eliminate dopo il completamento dell'avvio: in modo simile i moduli eliminano
+questa memoria dopo l'inizializzazione. ``__exit`` viene utilizzato per
+dichiarare che una funzione verrà utilizzata solo in fase di rimozione:
+la detta funzione verrà eliminata quando il file che la contiene non è
+compilato come modulo. Guardate l'header file per informazioni. Da notare che
+non ha senso avere una funzione marcata come ``__init`` e al tempo stesso
+esportata ai moduli utilizzando :c:func:`EXPORT_SYMBOL()` o
+:c:func:`EXPORT_SYMBOL_GPL()` - non funzionerà.
+
+
+:c:func:`__initcall()`/:c:func:`module_init()`
+----------------------------------------------
+
+Definite in  ``include/linux/init.h`` / ``include/linux/module.h``
+
+Molte parti del kernel funzionano bene come moduli (componenti del kernel
+caricabili dinamicamente). L'utilizzo delle macro :c:func:`module_init()`
+e :c:func:`module_exit()` semplifica la scrittura di codice che può funzionare
+sia come modulo, sia come parte del kernel, senza l'ausilio di #ifdef.
+
+La macro :c:func:`module_init()` definisce quale funzione dev'essere
+chiamata quando il modulo viene inserito (se il file è stato compilato come
+tale), o in fase di avvio : se il file non è stato compilato come modulo la
+macro :c:func:`module_init()` diventa equivalente a :c:func:`__initcall()`,
+la quale, tramite qualche magia del linker, s'assicura che la funzione venga
+chiamata durante l'avvio.
+
+La funzione può ritornare un numero d'errore negativo per scatenare un
+fallimento del caricamento (sfortunatamente, questo non ha effetto se il
+modulo è compilato come parte integrante del kernel). Questa funzione è chiamata
+in contesto utente con le interruzioni abilitate, quindi potrebbe dormire.
+
+
+:c:func:`module_exit()`
+-----------------------
+
+
+Definita in  ``include/linux/module.h``
+
+Questa macro definisce la funzione che dev'essere chiamata al momento della
+rimozione (o mai, nel caso in cui il file sia parte integrante del kernel).
+Essa verrà chiamata solo quando il contatore d'uso del modulo raggiunge lo
+zero. Questa funzione può anche dormire, ma non può fallire: tutto dev'essere
+ripulito prima che la funzione ritorni.
+
+Da notare che questa macro è opzionale: se non presente, il modulo non sarà
+removibile (a meno che non usiate 'rmmod -f' ).
+
+
+:c:func:`try_module_get()`/:c:func:`module_put()`
+-------------------------------------------------
+
+Definite in ``include/linux/module.h``
+
+Queste funzioni maneggiano il contatore d'uso del modulo per proteggerlo dalla
+rimozione (in aggiunta, un modulo non può essere rimosso se un altro modulo
+utilizzo uno dei sui simboli esportati: vedere di seguito). Prima di eseguire
+codice del modulo, dovreste chiamare :c:func:`try_module_get()` su quel modulo:
+se fallisce significa che il modulo è stato rimosso e dovete agire come se
+non fosse presente. Altrimenti, potete accedere al modulo in sicurezza, e
+chiamare :c:func:`module_put()` quando avete finito.
+
+La maggior parte delle strutture registrabili hanno un campo owner
+(proprietario), come nella struttura
+:c:type:`struct file_operations <file_operations>`.
+Impostate questo campo al valore della macro ``THIS_MODULE``.
+
+
+Code d'attesa ``include/linux/wait.h``
+======================================
+
+**[DORMONO]**
+
+Una coda d'attesa è usata per aspettare che qualcuno vi attivi quando una
+certa condizione s'avvera. Per evitare corse critiche, devono essere usate
+con cautela. Dichiarate una :c:type:`wait_queue_head_t`, e poi i processi
+che vogliono attendere il verificarsi di quella condizione dichiareranno
+una :c:type:`wait_queue_entry_t` facendo riferimento a loro stessi, poi
+metteranno questa in coda.
+
+Dichiarazione
+-------------
+
+Potere dichiarare una ``wait_queue_head_t`` utilizzando la macro
+:c:func:`DECLARE_WAIT_QUEUE_HEAD()` oppure utilizzando la procedura
+:c:func:`init_waitqueue_head()` nel vostro codice d'inizializzazione.
+
+Accodamento
+-----------
+
+Mettersi in una coda d'attesa è piuttosto complesso, perché dovete
+mettervi in coda prima di verificare la condizione. Esiste una macro
+a questo scopo: :c:func:`wait_event_interruptible()` (``include/linux/wait.h``).
+Il primo argomento è la testa della coda d'attesa, e il secondo è
+un'espressione che dev'essere valutata; la macro ritorna 0 quando questa
+espressione è vera, altrimenti ``-ERESTARTSYS`` se è stato ricevuto un segnale.
+La versione :c:func:`wait_event()` ignora i segnali.
+
+Svegliare una procedura in coda
+-------------------------------
+
+Chiamate :c:func:`wake_up()` (``include/linux/wait.h``); questa attiverà tutti
+i processi in coda. Ad eccezione se uno di questi è impostato come
+``TASK_EXCLUSIVE``, in questo caso i rimanenti non verranno svegliati.
+Nello stesso header file esistono altre varianti di questa funzione.
+
+Operazioni atomiche
+===================
+
+Certe operazioni sono garantite come atomiche su tutte le piattaforme.
+Il primo gruppo di operazioni utilizza :c:type:`atomic_t`
+(``include/asm/atomic.h``); questo contiene un intero con segno (minimo 32bit),
+e dovete utilizzare queste funzione per modificare o leggere variabili di tipo
+:c:type:`atomic_t`. :c:func:`atomic_read()` e :c:func:`atomic_set()` leggono ed
+impostano il contatore, :c:func:`atomic_add()`, :c:func:`atomic_sub()`,
+:c:func:`atomic_inc()`, :c:func:`atomic_dec()`, e
+:c:func:`atomic_dec_and_test()` (ritorna vero se raggiunge zero dopo essere
+stata decrementata).
+
+Sì. Ritorna vero (ovvero != 0) se la variabile atomica è zero.
+
+Da notare che queste funzioni sono più lente rispetto alla normale aritmetica,
+e quindi non dovrebbero essere usate a sproposito.
+
+Il secondo gruppo di operazioni atomiche sono definite in
+``include/linux/bitops.h`` ed agiscono sui bit d'una variabile di tipo
+``unsigned long``. Queste operazioni prendono come argomento un puntatore
+alla variabile, e un numero di bit dove 0 è quello meno significativo.
+:c:func:`set_bit()`, :c:func:`clear_bit()` e :c:func:`change_bit()`
+impostano, cancellano, ed invertono il bit indicato.
+:c:func:`test_and_set_bit()`, :c:func:`test_and_clear_bit()` e
+:c:func:`test_and_change_bit()` fanno la stessa cosa, ad eccezione che
+ritornano vero se il bit era impostato; queste sono particolarmente
+utili quando si vuole impostare atomicamente dei flag.
+
+Con queste operazioni è possibile utilizzare indici di bit che eccedono
+il valore ``BITS_PER_LONG``. Il comportamento è strano sulle piattaforme
+big-endian quindi è meglio evitarlo.
+
+Simboli
+=======
+
+All'interno del kernel, si seguono le normali regole del linker (ovvero,
+a meno che un simbolo non venga dichiarato con visibilita limitata ad un
+file con la parola chiave ``static``, esso può essere utilizzato in qualsiasi
+parte del kernel). Nonostante ciò, per i moduli, esiste una tabella dei
+simboli esportati che limita i punti di accesso al kernel. Anche i moduli
+possono esportare simboli.
+
+:c:func:`EXPORT_SYMBOL()`
+-------------------------
+
+Definita in ``include/linux/export.h``
+
+Questo è il classico metodo per esportare un simbolo: i moduli caricati
+dinamicamente potranno utilizzare normalmente il simbolo.
+
+:c:func:`EXPORT_SYMBOL_GPL()`
+-----------------------------
+
+Definita in ``include/linux/export.h``
+
+Essa è simile a :c:func:`EXPORT_SYMBOL()` ad eccezione del fatto che i
+simboli esportati con :c:func:`EXPORT_SYMBOL_GPL()` possono essere
+utilizzati solo dai moduli che hanno dichiarato una licenza compatibile
+con la GPL attraverso :c:func:`MODULE_LICENSE()`. Questo implica che la
+funzione esportata è considerata interna, e non una vera e propria interfaccia.
+Alcuni manutentori e sviluppatori potrebbero comunque richiedere
+:c:func:`EXPORT_SYMBOL_GPL()` quando si aggiungono nuove funzionalità o
+interfacce.
+
+Procedure e convenzioni
+=======================
+
+Liste doppiamente concatenate ``include/linux/list.h``
+------------------------------------------------------
+
+Un tempo negli header del kernel c'erano tre gruppi di funzioni per
+le liste concatenate, ma questa è stata la vincente. Se non avete particolari
+necessità per una semplice lista concatenata, allora questa è una buona scelta.
+
+In particolare, :c:func:`list_for_each_entry()` è utile.
+
+Convenzione dei valori di ritorno
+---------------------------------
+
+Per codice chiamato in contesto utente, è molto comune sfidare le convenzioni
+C e ritornare 0 in caso di successo, ed un codice di errore negativo
+(eg. ``-EFAULT``) nei casi fallimentari. Questo potrebbe essere controintuitivo
+a prima vista, ma è abbastanza diffuso nel kernel.
+
+Utilizzate :c:func:`ERR_PTR()` (``include/linux/err.h``) per codificare
+un numero d'errore negativo in un puntatore, e :c:func:`IS_ERR()` e
+:c:func:`PTR_ERR()` per recuperarlo di nuovo: così si evita d'avere un
+puntatore dedicato per il numero d'errore. Da brividi, ma in senso positivo.
+
+Rompere la compilazione
+-----------------------
+
+Linus e gli altri sviluppatori a volte cambiano i nomi delle funzioni e
+delle strutture nei kernel in sviluppo; questo non è solo per tenere
+tutti sulle spine: questo riflette cambiamenti fondamentati (eg. la funzione
+non può più essere chiamata con le funzioni attive, o fa controlli aggiuntivi,
+o non fa più controlli che venivano fatti in precedenza). Solitamente a questo
+s'accompagna un'adeguata e completa nota sulla lista di discussone
+linux-kernel; cercate negli archivi.
+Solitamente eseguire una semplice sostituzione su tutto un file rendere
+le cose **peggiori**.
+
+Inizializzazione dei campi d'una struttura
+------------------------------------------
+
+Il metodo preferito per l'inizializzazione delle strutture è quello
+di utilizzare gli inizializzatori designati, come definiti nello
+standard ISO C99, eg::
+
+    static struct block_device_operations opt_fops = {
+            .open               = opt_open,
+            .release            = opt_release,
+            .ioctl              = opt_ioctl,
+            .check_media_change = opt_media_change,
+    };
+
+Questo rende più facile la ricerca con grep, e rende più chiaro quale campo
+viene impostato. Dovreste fare così perché si mostra meglio.
+
+Estensioni GNU
+--------------
+
+Le estensioni GNU sono esplicitamente permesse nel kernel Linux. Da notare
+che alcune delle più complesse non sono ben supportate, per via dello scarso
+sviluppo, ma le seguenti sono da considerarsi la norma (per maggiori dettagli,
+leggete la sezione "C Extensions" nella pagina info di GCC - Sì, davvero
+la pagina info, la pagina man è solo un breve riassunto delle cose nella
+pagina info).
+
+-  Funzioni inline
+
+-  Istruzioni in espressioni (ie. il costrutto ({ and }) ).
+
+-  Dichiarate attributi di una funzione / variabile / tipo
+   (__attribute__)
+
+-  typeof
+
+-  Array con lunghezza zero
+
+-  Macro varargs
+
+-  Aritmentica sui puntatori void
+
+-  Inizializzatori non costanti
+
+-  Istruzioni assembler (non al di fuori di 'arch/' e 'include/asm/')
+
+-  Nomi delle funzioni come stringhe (__func__).
+
+-  __builtin_constant_p()
+
+Siate sospettosi quando utilizzate long long nel kernel, il codice generato
+da gcc è orribile ed anche peggio: le divisioni e le moltiplicazioni non
+funzionano sulle piattaforme i386 perché le rispettive funzioni di runtime
+di GCC non sono incluse nell'ambiente del kernel.
+
+C++
+---
+
+Solitamente utilizzare il C++ nel kernel è una cattiva idea perché
+il kernel non fornisce il necessario ambiente di runtime e gli header file
+non sono stati verificati. Rimane comunque possibile, ma non consigliato.
+Se davvero volete usarlo, almeno evitate le eccezioni.
+
+NUMif
+-----
+
+Viene generalmente considerato più pulito l'uso delle macro negli header file
+(o all'inizio dei file .c) per astrarre funzioni piuttosto che utlizzare
+l'istruzione di pre-processore \`#if' all'interno del codice sorgente.
+
+Mettere le vostre cose nel kernel
+=================================
+
+Al fine d'avere le vostre cose in ordine per l'inclusione ufficiale, o
+anche per avere patch pulite, c'è del lavoro amministrativo da fare:
+
+-  Trovare di chi è lo stagno in cui state pisciando. Guardare in cima
+   ai file sorgenti, all'interno del file ``MAINTAINERS``, ed alla fine
+   di tutti nel file ``CREDITS``. Dovreste coordinarvi con queste persone
+   per evitare di duplicare gli sforzi, o provare qualcosa che è già stato
+   rigettato.
+
+   Assicuratevi di mettere il vostro nome ed indirizzo email in cima a
+   tutti i file che create o che mangeggiate significativamente. Questo è
+   il primo posto dove le persone guarderanno quando troveranno un baco,
+   o quando **loro** vorranno fare una modifica.
+
+-  Solitamente vorrete un'opzione di configurazione per la vostra modifica
+   al kernel. Modificate ``Kconfig`` nella cartella giusta. Il linguaggio
+   Config è facile con copia ed incolla, e c'è una completa documentazione
+   nel file ``Documentation/kbuild/kconfig-language.txt``.
+
+   Nella descrizione della vostra opzione, assicuratevi di parlare sia agli
+   utenti esperti sia agli utente che non sanno nulla del vostro lavoro.
+   Menzionate qui le incompatibilità ed i problemi. Chiaramente la
+   descrizione deve terminare con “if in doubt, say N” (se siete in dubbio,
+   dite N) (oppure, occasionalmente, \`Y'); questo è per le persone che non
+   hanno idea di che cosa voi stiate parlando.
+
+-  Modificate il file ``Makefile``: le variabili CONFIG sono esportate qui,
+   quindi potete solitamente aggiungere una riga come la seguete
+   "obj-$(CONFIG_xxx) += xxx.o". La sintassi è documentata nel file
+   ``Documentation/kbuild/makefiles.txt``.
+
+-  Aggiungete voi stessi in ``CREDITS`` se avete fatto qualcosa di notevole,
+   solitamente qualcosa che supera il singolo file (comunque il vostro nome
+   dovrebbe essere all'inizio dei file sorgenti). ``MAINTAINERS`` significa
+   che volete essere consultati quando vengono fatte delle modifiche ad un
+   sottosistema, e quando ci sono dei bachi; questo implica molto di più
+   di un semplice impegno su una parte del codice.
+
+-  Infine, non dimenticatevi di leggere
+   ``Documentation/process/submitting-patches.rst`` e possibilmente anche
+   ``Documentation/process/submitting-drivers.rst``.
+
+Trucchetti del kernel
+=====================
+
+Dopo una rapida occhiata al codice, questi sono i preferiti. Sentitevi liberi
+di aggiungerne altri.
+
+``arch/x86/include/asm/delay.h``::
+
+    #define ndelay(n) (__builtin_constant_p(n) ? \
+            ((n) > 20000 ? __bad_ndelay() : __const_udelay((n) * 5ul)) : \
+            __ndelay(n))
+
+
+``include/linux/fs.h``::
+
+    /*
+     * Kernel pointers have redundant information, so we can use a
+     * scheme where we can return either an error code or a dentry
+     * pointer with the same return value.
+     *
+     * This should be a per-architecture thing, to allow different
+     * error and pointer decisions.
+     */
+     #define ERR_PTR(err)    ((void *)((long)(err)))
+     #define PTR_ERR(ptr)    ((long)(ptr))
+     #define IS_ERR(ptr)     ((unsigned long)(ptr) > (unsigned long)(-1000))
+
+``arch/x86/include/asm/uaccess_32.h:``::
+
+    #define copy_to_user(to,from,n)                         \
+            (__builtin_constant_p(n) ?                      \
+             __constant_copy_to_user((to),(from),(n)) :     \
+             __generic_copy_to_user((to),(from),(n)))
+
+
+``arch/sparc/kernel/head.S:``::
+
+    /*
+     * Sun people can't spell worth damn. "compatability" indeed.
+     * At least we *know* we can't spell, and use a spell-checker.
+     */
+
+    /* Uh, actually Linus it is I who cannot spell. Too much murky
+     * Sparc assembly will do this to ya.
+     */
+    C_LABEL(cputypvar):
+            .asciz "compatibility"
+
+    /* Tested on SS-5, SS-10. Probably someone at Sun applied a spell-checker. */
+            .align 4
+    C_LABEL(cputypvar_sun4m):
+            .asciz "compatible"
+
+
+``arch/sparc/lib/checksum.S:``::
+
+            /* Sun, you just can't beat me, you just can't.  Stop trying,
+             * give up.  I'm serious, I am going to kick the living shit
+             * out of you, game over, lights out.
+             */
+
+
+Ringraziamenti
+==============
+
+Ringrazio Andi Kleen per le sue idee, le risposte alle mie domande,
+le correzioni dei miei errori, l'aggiunta di contenuti, eccetera.
+Philipp Rumpf per l'ortografia e per aver reso più chiaro il testo, e
+per alcuni eccellenti punti tutt'altro che ovvi. Werner Almesberger
+per avermi fornito un ottimo riassunto di :c:func:`disable_irq()`,
+e Jes Sorensen e Andrea Arcangeli per le precisazioni. Michael Elizabeth
+Chastain per aver verificato ed aggiunto la sezione configurazione.
+Telsa Gwynne per avermi insegnato DocBook.
diff --git a/Documentation/translations/it_IT/kernel-hacking/index.rst b/Documentation/translations/it_IT/kernel-hacking/index.rst
new file mode 100644
index 000000000000..50228380bd50
--- /dev/null
+++ b/Documentation/translations/it_IT/kernel-hacking/index.rst
@@ -0,0 +1,16 @@
+.. include:: ../disclaimer-ita.rst
+
+:Original: :ref:`Documentation/kernel-hacking/index.rst <kernel_hacking>`
+:Translator: Federico Vaga <federico.vaga@vaga.pv.it>
+
+.. _it_kernel_hacking:
+
+============================
+Guida all'hacking del kernel
+============================
+
+.. toctree::
+   :maxdepth: 2
+
+   hacking
+   locking
diff --git a/Documentation/translations/it_IT/kernel-hacking/locking.rst b/Documentation/translations/it_IT/kernel-hacking/locking.rst
new file mode 100644
index 000000000000..753643622c23
--- /dev/null
+++ b/Documentation/translations/it_IT/kernel-hacking/locking.rst
@@ -0,0 +1,1493 @@
+.. include:: ../disclaimer-ita.rst
+
+:Original: :ref:`Documentation/kernel-hacking/locking.rst <kernel_hacking_lock>`
+:Translator: Federico Vaga <federico.vaga@vaga.pv.it>
+
+.. _it_kernel_hacking_lock:
+
+==========================================
+L'inaffidabile guida alla sincronizzazione
+==========================================
+
+:Author: Rusty Russell
+
+Introduzione
+============
+
+Benvenuto, alla notevole ed inaffidabile guida ai problemi di sincronizzazione
+(locking) nel kernel. Questo documento descrive il sistema di sincronizzazione
+nel kernel Linux 2.6.
+
+Dato il largo utilizzo del multi-threading e della prelazione nel kernel
+Linux, chiunque voglia dilettarsi col kernel deve conoscere i concetti
+fondamentali della concorrenza e della sincronizzazione nei sistemi
+multi-processore.
+
+Il problema con la concorrenza
+==============================
+
+(Saltatelo se sapete già cos'è una corsa critica).
+
+In un normale programma, potete incrementare un contatore nel seguente modo:
+
+::
+
+          contatore++;
+
+Questo è quello che vi aspettereste che accada sempre:
+
+
+.. table:: Risultati attesi
+
+  +------------------------------------+------------------------------------+
+  | Istanza 1                          | Istanza 2                          |
+  +====================================+====================================+
+  | leggi contatore (5)                |                                    |
+  +------------------------------------+------------------------------------+
+  | aggiungi 1 (6)                     |                                    |
+  +------------------------------------+------------------------------------+
+  | scrivi contatore (6)               |                                    |
+  +------------------------------------+------------------------------------+
+  |                                    | leggi contatore (6)                |
+  +------------------------------------+------------------------------------+
+  |                                    | aggiungi 1 (7)                     |
+  +------------------------------------+------------------------------------+
+  |                                    | scrivi contatore (7)               |
+  +------------------------------------+------------------------------------+
+
+Questo è quello che potrebbe succedere in realtà:
+
+.. table:: Possibile risultato
+
+  +------------------------------------+------------------------------------+
+  | Istanza 1                          | Istanza 2                          |
+  +====================================+====================================+
+  | leggi contatore (5)                |                                    |
+  +------------------------------------+------------------------------------+
+  |                                    | leggi contatore (5)                |
+  +------------------------------------+------------------------------------+
+  | aggiungi 1 (6)                     |                                    |
+  +------------------------------------+------------------------------------+
+  |                                    | aggiungi 1 (6)                     |
+  +------------------------------------+------------------------------------+
+  | scrivi contatore (6)               |                                    |
+  +------------------------------------+------------------------------------+
+  |                                    | scrivi contatore (6)               |
+  +------------------------------------+------------------------------------+
+
+
+Corse critiche e sezioni critiche
+---------------------------------
+
+Questa sovrapposizione, ovvero quando un risultato dipende dal tempo che
+intercorre fra processi diversi, è chiamata corsa critica. La porzione
+di codice che contiene questo problema è chiamata sezione critica.
+In particolar modo da quando Linux ha incominciato a girare su
+macchine multi-processore, le sezioni critiche sono diventate uno dei
+maggiori problemi di progettazione ed implementazione del kernel.
+
+La prelazione può sortire gli stessi effetti, anche se c'è una sola CPU:
+interrompendo un processo nella sua sezione critica otterremo comunque
+la stessa corsa critica. In questo caso, il thread che si avvicenda
+nell'esecuzione potrebbe eseguire anch'esso la sezione critica.
+
+La soluzione è quella di riconoscere quando avvengono questi accessi
+simultanei, ed utilizzare i *lock* per accertarsi che solo un'istanza
+per volta possa entrare nella sezione critica. Il kernel offre delle buone
+funzioni a questo scopo. E poi ci sono quelle meno buone, ma farò finta
+che non esistano.
+
+Sincronizzazione nel kernel Linux
+=================================
+
+Se posso darvi un suggerimento: non dormite mai con qualcuno più pazzo di
+voi. Ma se dovessi darvi un suggerimento sulla sincronizzazione:
+**mantenetela semplice**.
+
+Siate riluttanti nell'introduzione di nuovi *lock*.
+
+Abbastanza strano, quest'ultimo è l'esatto opposto del mio suggerimento
+su quando **avete** dormito con qualcuno più pazzo di voi. E dovreste
+pensare a prendervi un cane bello grande.
+
+I due principali tipi di *lock* nel kernel: spinlock e mutex
+------------------------------------------------------------
+
+Ci sono due tipi principali di *lock* nel kernel. Il tipo fondamentale è lo
+spinlock (``include/asm/spinlock.h``), un semplice *lock* che può essere
+trattenuto solo da un processo: se non si può trattenere lo spinlock, allora
+rimane in attesa attiva (in inglese *spinning*) finché non ci riesce.
+Gli spinlock sono molto piccoli e rapidi, possono essere utilizzati ovunque.
+
+Il secondo tipo è il mutex (``include/linux/mutex.h``): è come uno spinlock,
+ma potreste bloccarvi trattenendolo. Se non potete trattenere un mutex
+il vostro processo si auto-sospenderà; verrà riattivato quando il mutex
+verrà rilasciato. Questo significa che il processore potrà occuparsi d'altro
+mentre il vostro processo è in attesa. Esistono molti casi in cui non potete
+permettervi di sospendere un processo (vedere
+:ref:`Quali funzioni possono essere chiamate in modo sicuro dalle interruzioni? <it_sleeping-things>`)
+e quindi dovrete utilizzare gli spinlock.
+
+Nessuno di questi *lock* è ricorsivo: vedere
+:ref:`Stallo: semplice ed avanzato <it_deadlock>`
+
+I *lock* e i kernel per sistemi monoprocessore
+----------------------------------------------
+
+Per i kernel compilati senza ``CONFIG_SMP`` e senza ``CONFIG_PREEMPT``
+gli spinlock non esistono. Questa è un'ottima scelta di progettazione:
+quando nessun altro processo può essere eseguito in simultanea, allora
+non c'è la necessità di avere un *lock*.
+
+Se il kernel è compilato senza ``CONFIG_SMP`` ma con ``CONFIG_PREEMPT``,
+allora gli spinlock disabilitano la prelazione; questo è sufficiente a
+prevenire le corse critiche. Nella maggior parte dei casi, possiamo considerare
+la prelazione equivalente ad un sistema multi-processore senza preoccuparci
+di trattarla indipendentemente.
+
+Dovreste verificare sempre la sincronizzazione con le opzioni ``CONFIG_SMP`` e
+``CONFIG_PREEMPT`` abilitate, anche quando non avete un sistema
+multi-processore, questo vi permetterà di identificare alcuni problemi
+di sincronizzazione.
+
+Come vedremo di seguito, i mutex continuano ad esistere perché sono necessari
+per la sincronizzazione fra processi in contesto utente.
+
+Sincronizzazione in contesto utente
+-----------------------------------
+
+Se avete una struttura dati che verrà utilizzata solo dal contesto utente,
+allora, per proteggerla, potete utilizzare un semplice mutex
+(``include/linux/mutex.h``). Questo è il caso più semplice: inizializzate il
+mutex; invocate :c:func:`mutex_lock_interruptible()` per trattenerlo e
+:c:func:`mutex_unlock()` per rilasciarlo. C'è anche :c:func:`mutex_lock()`
+ma questa dovrebbe essere evitata perché non ritorna in caso di segnali.
+
+Per esempio: ``net/netfilter/nf_sockopt.c`` permette la registrazione
+di nuove chiamate per :c:func:`setsockopt()` e :c:func:`getsockopt()`
+usando la funzione :c:func:`nf_register_sockopt()`. La registrazione e
+la rimozione vengono eseguite solamente quando il modulo viene caricato
+o scaricato (e durante l'avvio del sistema, qui non abbiamo concorrenza),
+e la lista delle funzioni registrate viene consultata solamente quando
+:c:func:`setsockopt()` o :c:func:`getsockopt()` sono sconosciute al sistema.
+In questo caso ``nf_sockopt_mutex`` è perfetto allo scopo, in particolar modo
+visto che setsockopt e getsockopt potrebbero dormire.
+
+Sincronizzazione fra il contesto utente e i softirq
+---------------------------------------------------
+
+Se un softirq condivide dati col contesto utente, avete due problemi.
+Primo, il contesto utente corrente potrebbe essere interroto da un softirq,
+e secondo, la sezione critica potrebbe essere eseguita da un altro
+processore. Questo è quando :c:func:`spin_lock_bh()`
+(``include/linux/spinlock.h``) viene utilizzato. Questo disabilita i softirq
+sul processore e trattiene il *lock*. Invece, :c:func:`spin_unlock_bh()` fa
+l'opposto. (Il suffisso '_bh' è un residuo storico che fa riferimento al
+"Bottom Halves", il vecchio nome delle interruzioni software. In un mondo
+perfetto questa funzione si chiamerebbe 'spin_lock_softirq()').
+
+Da notare che in questo caso potete utilizzare anche :c:func:`spin_lock_irq()`
+o :c:func:`spin_lock_irqsave()`, queste fermano anche le interruzioni hardware:
+vedere :ref:`Contesto di interruzione hardware <it_hardirq-context>`.
+
+Questo funziona alla perfezione anche sui sistemi monoprocessore: gli spinlock
+svaniscono e questa macro diventa semplicemente :c:func:`local_bh_disable()`
+(``include/linux/interrupt.h``), la quale impedisce ai softirq d'essere
+eseguiti.
+
+Sincronizzazione fra contesto utente e i tasklet
+------------------------------------------------
+
+Questo caso è uguale al precedente, un tasklet viene eseguito da un softirq.
+
+Sincronizzazione fra contesto utente e i timer
+----------------------------------------------
+
+Anche questo caso è uguale al precedente, un timer viene eseguito da un
+softirq.
+Dal punto di vista della sincronizzazione, tasklet e timer sono identici.
+
+Sincronizzazione fra tasklet e timer
+------------------------------------
+
+Qualche volta un tasklet od un timer potrebbero condividere i dati con
+un altro tasklet o timer
+
+Lo stesso tasklet/timer
+~~~~~~~~~~~~~~~~~~~~~~~
+
+Dato che un tasklet non viene mai eseguito contemporaneamente su due
+processori, non dovete preoccuparvi che sia rientrante (ovvero eseguito
+più volte in contemporanea), perfino su sistemi multi-processore.
+
+Differenti tasklet/timer
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Se un altro tasklet/timer vuole condividere dati col vostro tasklet o timer,
+allora avrete bisogno entrambe di :c:func:`spin_lock()` e
+:c:func:`spin_unlock()`. Qui :c:func:`spin_lock_bh()` è inutile, siete già
+in un tasklet ed avete la garanzia che nessun altro verrà eseguito sullo
+stesso processore.
+
+Sincronizzazione fra softirq
+----------------------------
+
+Spesso un softirq potrebbe condividere dati con se stesso o un tasklet/timer.
+
+Lo stesso softirq
+~~~~~~~~~~~~~~~~~
+
+Lo stesso softirq può essere eseguito su un diverso processore: allo scopo
+di migliorare le prestazioni potete utilizzare dati riservati ad ogni
+processore (vedere :ref:`Dati per processore <it_per-cpu>`). Se siete arrivati
+fino a questo punto nell'uso dei softirq, probabilmente tenete alla scalabilità
+delle prestazioni abbastanza da giustificarne la complessità aggiuntiva.
+
+Dovete utilizzare :c:func:`spin_lock()` e :c:func:`spin_unlock()` per
+proteggere i dati condivisi.
+
+Diversi Softirqs
+~~~~~~~~~~~~~~~~
+
+Dovete utilizzare :c:func:`spin_lock()` e :c:func:`spin_unlock()` per
+proteggere i dati condivisi, che siano timer, tasklet, diversi softirq o
+lo stesso o altri softirq: uno qualsiasi di essi potrebbe essere in esecuzione
+su un diverso processore.
+
+.. _`it_hardirq-context`:
+
+Contesto di interruzione hardware
+=================================
+
+Solitamente le interruzioni hardware comunicano con un tasklet o un softirq.
+Spesso questo si traduce nel mettere in coda qualcosa da fare che verrà
+preso in carico da un softirq.
+
+Sincronizzazione fra interruzioni hardware e softirq/tasklet
+------------------------------------------------------------
+
+Se un gestore di interruzioni hardware condivide dati con un softirq, allora
+avrete due preoccupazioni. Primo, il softirq può essere interrotto da
+un'interruzione hardware, e secondo, la sezione critica potrebbe essere
+eseguita da un'interruzione hardware su un processore diverso. Questo è il caso
+dove :c:func:`spin_lock_irq()` viene utilizzato. Disabilita le interruzioni
+sul processore che l'esegue, poi trattiene il lock. :c:func:`spin_unlock_irq()`
+fa l'opposto.
+
+Il gestore d'interruzione hardware non usa :c:func:`spin_lock_irq()` perché
+i softirq non possono essere eseguiti quando il gestore d'interruzione hardware
+è in esecuzione: per questo si può usare :c:func:`spin_lock()`, che è un po'
+più veloce. L'unica eccezione è quando un altro gestore d'interruzioni
+hardware utilizza lo stesso *lock*: :c:func:`spin_lock_irq()` impedirà a questo
+secondo gestore di interrompere quello in esecuzione.
+
+Questo funziona alla perfezione anche sui sistemi monoprocessore: gli spinlock
+svaniscono e questa macro diventa semplicemente :c:func:`local_irq_disable()`
+(``include/asm/smp.h``), la quale impedisce a softirq/tasklet/BH d'essere
+eseguiti.
+
+:c:func:`spin_lock_irqsave()` (``include/linux/spinlock.h``) è una variante che
+salva lo stato delle interruzioni in una variabile, questa verrà poi passata
+a :c:func:`spin_unlock_irqrestore()`. Questo significa che lo stesso codice
+potrà essere utilizzato in un'interruzione hardware (dove le interruzioni sono
+già disabilitate) e in un softirq (dove la disabilitazione delle interruzioni
+è richiesta).
+
+Da notare che i softirq (e quindi tasklet e timer) sono eseguiti al ritorno
+da un'interruzione hardware, quindi :c:func:`spin_lock_irq()` interrompe
+anche questi. Tenuto conto di questo si può dire che
+:c:func:`spin_lock_irqsave()` è la funzione di sincronizzazione più generica
+e potente.
+
+Sincronizzazione fra due gestori d'interruzioni hardware
+--------------------------------------------------------
+
+Condividere dati fra due gestori di interruzione hardware è molto raro, ma se
+succede, dovreste usare :c:func:`spin_lock_irqsave()`: è una specificità
+dell'architettura il fatto che tutte le interruzioni vengano interrotte
+quando si eseguono di gestori di interruzioni.
+
+Bigino della sincronizzazione
+=============================
+
+Pete Zaitcev ci offre il seguente riassunto:
+
+-  Se siete in un contesto utente (una qualsiasi chiamata di sistema)
+   e volete sincronizzarvi con altri processi, usate i mutex. Potete trattenere
+   il mutex e dormire (``copy_from_user*(`` o ``kmalloc(x,GFP_KERNEL)``).
+
+-  Altrimenti (== i dati possono essere manipolati da un'interruzione) usate
+   :c:func:`spin_lock_irqsave()` e :c:func:`spin_unlock_irqrestore()`.
+
+-  Evitate di trattenere uno spinlock per più di 5 righe di codice incluse
+   le chiamate a funzione (ad eccezione di quell per l'accesso come
+   :c:func:`readb()`).
+
+Tabella dei requisiti minimi
+----------------------------
+
+La tabella seguente illustra i requisiti **minimi** per la sincronizzazione fra
+diversi contesti. In alcuni casi, lo stesso contesto può essere eseguito solo
+da un processore per volta, quindi non ci sono requisiti per la
+sincronizzazione (per esempio, un thread può essere eseguito solo su un
+processore alla volta, ma se deve condividere dati con un altro thread, allora
+la sincronizzazione è necessaria).
+
+Ricordatevi il suggerimento qui sopra: potete sempre usare
+:c:func:`spin_lock_irqsave()`, che è un sovrainsieme di tutte le altre funzioni
+per spinlock.
+
+============== ============= ============= ========= ========= ========= ========= ======= ======= ============== ==============
+.              IRQ Handler A IRQ Handler B Softirq A Softirq B Tasklet A Tasklet B Timer A Timer B User Context A User Context B
+============== ============= ============= ========= ========= ========= ========= ======= ======= ============== ==============
+IRQ Handler A  None
+IRQ Handler B  SLIS          None
+Softirq A      SLI           SLI           SL
+Softirq B      SLI           SLI           SL        SL
+Tasklet A      SLI           SLI           SL        SL        None
+Tasklet B      SLI           SLI           SL        SL        SL        None
+Timer A        SLI           SLI           SL        SL        SL        SL        None
+Timer B        SLI           SLI           SL        SL        SL        SL        SL      None
+User Context A SLI           SLI           SLBH      SLBH      SLBH      SLBH      SLBH    SLBH    None
+User Context B SLI           SLI           SLBH      SLBH      SLBH      SLBH      SLBH    SLBH    MLI            None
+============== ============= ============= ========= ========= ========= ========= ======= ======= ============== ==============
+
+Table: Tabella dei requisiti per la sincronizzazione
+
++--------+----------------------------+
+| SLIS   | spin_lock_irqsave          |
++--------+----------------------------+
+| SLI    | spin_lock_irq              |
++--------+----------------------------+
+| SL     | spin_lock                  |
++--------+----------------------------+
+| SLBH   | spin_lock_bh               |
++--------+----------------------------+
+| MLI    | mutex_lock_interruptible   |
++--------+----------------------------+
+
+Table: Legenda per la tabella dei requisiti per la sincronizzazione
+
+Le funzioni *trylock*
+=====================
+
+Ci sono funzioni che provano a trattenere un *lock* solo una volta e
+ritornano immediatamente comunicato il successo od il fallimento
+dell'operazione. Posso essere usate quando non serve accedere ai dati
+protetti dal *lock* quando qualche altro thread lo sta già facendo
+trattenendo il *lock*. Potrete acquisire il *lock* più tardi se vi
+serve accedere ai dati protetti da questo *lock*.
+
+La funzione :c:func:`spin_trylock()` non ritenta di acquisire il *lock*,
+se ci riesce al primo colpo ritorna un valore diverso da zero, altrimenti
+se fallisce ritorna 0. Questa funzione può essere utilizzata in un qualunque
+contesto, ma come :c:func:`spin_lock()`: dovete disabilitare i contesti che
+potrebbero interrompervi e quindi trattenere lo spinlock.
+
+La funzione :c:func:`mutex_trylock()` invece di sospendere il vostro processo
+ritorna un valore diverso da zero se è possibile trattenere il lock al primo
+colpo, altrimenti se fallisce ritorna 0. Nonostante non dorma, questa funzione
+non può essere usata in modo sicuro in contesti di interruzione hardware o
+software.
+
+Esempi più comuni
+=================
+
+Guardiamo un semplice esempio: una memoria che associa nomi a numeri.
+La memoria tiene traccia di quanto spesso viene utilizzato ogni oggetto;
+quando è piena, l'oggetto meno usato viene eliminato.
+
+Tutto in contesto utente
+------------------------
+
+Nel primo esempio, supponiamo che tutte le operazioni avvengano in contesto
+utente (in soldoni, da una chiamata di sistema), quindi possiamo dormire.
+Questo significa che possiamo usare i mutex per proteggere la nostra memoria
+e tutti gli oggetti che contiene. Ecco il codice::
+
+    #include <linux/list.h>
+    #include <linux/slab.h>
+    #include <linux/string.h>
+    #include <linux/mutex.h>
+    #include <asm/errno.h>
+
+    struct object
+    {
+            struct list_head list;
+            int id;
+            char name[32];
+            int popularity;
+    };
+
+    /* Protects the cache, cache_num, and the objects within it */
+    static DEFINE_MUTEX(cache_lock);
+    static LIST_HEAD(cache);
+    static unsigned int cache_num = 0;
+    #define MAX_CACHE_SIZE 10
+
+    /* Must be holding cache_lock */
+    static struct object *__cache_find(int id)
+    {
+            struct object *i;
+
+            list_for_each_entry(i, &cache, list)
+                    if (i->id == id) {
+                            i->popularity++;
+                            return i;
+                    }
+            return NULL;
+    }
+
+    /* Must be holding cache_lock */
+    static void __cache_delete(struct object *obj)
+    {
+            BUG_ON(!obj);
+            list_del(&obj->list);
+            kfree(obj);
+            cache_num--;
+    }
+
+    /* Must be holding cache_lock */
+    static void __cache_add(struct object *obj)
+    {
+            list_add(&obj->list, &cache);
+            if (++cache_num > MAX_CACHE_SIZE) {
+                    struct object *i, *outcast = NULL;
+                    list_for_each_entry(i, &cache, list) {
+                            if (!outcast || i->popularity < outcast->popularity)
+                                    outcast = i;
+                    }
+                    __cache_delete(outcast);
+            }
+    }
+
+    int cache_add(int id, const char *name)
+    {
+            struct object *obj;
+
+            if ((obj = kmalloc(sizeof(*obj), GFP_KERNEL)) == NULL)
+                    return -ENOMEM;
+
+            strlcpy(obj->name, name, sizeof(obj->name));
+            obj->id = id;
+            obj->popularity = 0;
+
+            mutex_lock(&cache_lock);
+            __cache_add(obj);
+            mutex_unlock(&cache_lock);
+            return 0;
+    }
+
+    void cache_delete(int id)
+    {
+            mutex_lock(&cache_lock);
+            __cache_delete(__cache_find(id));
+            mutex_unlock(&cache_lock);
+    }
+
+    int cache_find(int id, char *name)
+    {
+            struct object *obj;
+            int ret = -ENOENT;
+
+            mutex_lock(&cache_lock);
+            obj = __cache_find(id);
+            if (obj) {
+                    ret = 0;
+                    strcpy(name, obj->name);
+            }
+            mutex_unlock(&cache_lock);
+            return ret;
+    }
+
+Da notare che ci assicuriamo sempre di trattenere cache_lock quando
+aggiungiamo, rimuoviamo od ispezioniamo la memoria: sia la struttura
+della memoria che il suo contenuto sono protetti dal *lock*. Questo
+caso è semplice dato che copiamo i dati dall'utente e non permettiamo
+mai loro di accedere direttamente agli oggetti.
+
+C'è una piccola ottimizzazione qui: nella funzione :c:func:`cache_add()`
+impostiamo i campi dell'oggetto prima di acquisire il *lock*. Questo è
+sicuro perché nessun altro potrà accedervi finché non lo inseriremo
+nella memoria.
+
+Accesso dal contesto utente
+---------------------------
+
+Ora consideriamo il caso in cui :c:func:`cache_find()` può essere invocata
+dal contesto d'interruzione: sia hardware che software. Un esempio potrebbe
+essere un timer che elimina oggetti dalla memoria.
+
+Qui di seguito troverete la modifica nel formato *patch*: le righe ``-``
+sono quelle rimosse, mentre quelle ``+`` sono quelle aggiunte.
+
+::
+
+    --- cache.c.usercontext 2003-12-09 13:58:54.000000000 +1100
+    +++ cache.c.interrupt   2003-12-09 14:07:49.000000000 +1100
+    @@ -12,7 +12,7 @@
+             int popularity;
+     };
+
+    -static DEFINE_MUTEX(cache_lock);
+    +static DEFINE_SPINLOCK(cache_lock);
+     static LIST_HEAD(cache);
+     static unsigned int cache_num = 0;
+     #define MAX_CACHE_SIZE 10
+    @@ -55,6 +55,7 @@
+     int cache_add(int id, const char *name)
+     {
+             struct object *obj;
+    +        unsigned long flags;
+
+             if ((obj = kmalloc(sizeof(*obj), GFP_KERNEL)) == NULL)
+                     return -ENOMEM;
+    @@ -63,30 +64,33 @@
+             obj->id = id;
+             obj->popularity = 0;
+
+    -        mutex_lock(&cache_lock);
+    +        spin_lock_irqsave(&cache_lock, flags);
+             __cache_add(obj);
+    -        mutex_unlock(&cache_lock);
+    +        spin_unlock_irqrestore(&cache_lock, flags);
+             return 0;
+     }
+
+     void cache_delete(int id)
+     {
+    -        mutex_lock(&cache_lock);
+    +        unsigned long flags;
+    +
+    +        spin_lock_irqsave(&cache_lock, flags);
+             __cache_delete(__cache_find(id));
+    -        mutex_unlock(&cache_lock);
+    +        spin_unlock_irqrestore(&cache_lock, flags);
+     }
+
+     int cache_find(int id, char *name)
+     {
+             struct object *obj;
+             int ret = -ENOENT;
+    +        unsigned long flags;
+
+    -        mutex_lock(&cache_lock);
+    +        spin_lock_irqsave(&cache_lock, flags);
+             obj = __cache_find(id);
+             if (obj) {
+                     ret = 0;
+                     strcpy(name, obj->name);
+             }
+    -        mutex_unlock(&cache_lock);
+    +        spin_unlock_irqrestore(&cache_lock, flags);
+             return ret;
+     }
+
+Da notare che :c:func:`spin_lock_irqsave()` disabiliterà le interruzioni
+se erano attive, altrimenti non farà niente (quando siamo già in un contesto
+d'interruzione); dunque queste funzioni possono essere chiamante in
+sicurezza da qualsiasi contesto.
+
+Sfortunatamente, :c:func:`cache_add()` invoca :c:func:`kmalloc()` con
+l'opzione ``GFP_KERNEL`` che è permessa solo in contesto utente. Ho supposto
+che :c:func:`cache_add()` venga chiamata dal contesto utente, altrimenti
+questa opzione deve diventare un parametro di :c:func:`cache_add()`.
+
+Exposing Objects Outside This File
+----------------------------------
+
+Se i vostri oggetti contengono più informazioni, potrebbe non essere
+sufficiente copiare i dati avanti e indietro: per esempio, altre parti del
+codice potrebbero avere un puntatore a questi oggetti piuttosto che cercarli
+ogni volta. Questo introduce due problemi.
+
+Il primo problema è che utilizziamo ``cache_lock`` per proteggere gli oggetti:
+dobbiamo renderlo dinamico così che il resto del codice possa usarlo. Questo
+rende la sincronizzazione più complicata dato che non avviene più in un unico
+posto.
+
+Il secondo problema è il problema del ciclo di vita: se un'altra struttura
+mantiene un puntatore ad un oggetto, presumibilmente si aspetta che questo
+puntatore rimanga valido. Sfortunatamente, questo è garantito solo mentre
+si trattiene il *lock*, altrimenti qualcuno potrebbe chiamare
+:c:func:`cache_delete()` o peggio, aggiungere un oggetto che riutilizza lo
+stesso indirizzo.
+
+Dato che c'è un solo *lock*, non potete trattenerlo a vita: altrimenti
+nessun altro potrà eseguire il proprio lavoro.
+
+La soluzione a questo problema è l'uso di un contatore di riferimenti:
+chiunque punti ad un oggetto deve incrementare il contatore, e decrementarlo
+quando il puntatore non viene più usato. Quando il contatore raggiunge lo zero
+significa che non è più usato e l'oggetto può essere rimosso.
+
+Ecco il codice::
+
+    --- cache.c.interrupt   2003-12-09 14:25:43.000000000 +1100
+    +++ cache.c.refcnt  2003-12-09 14:33:05.000000000 +1100
+    @@ -7,6 +7,7 @@
+     struct object
+     {
+             struct list_head list;
+    +        unsigned int refcnt;
+             int id;
+             char name[32];
+             int popularity;
+    @@ -17,6 +18,35 @@
+     static unsigned int cache_num = 0;
+     #define MAX_CACHE_SIZE 10
+
+    +static void __object_put(struct object *obj)
+    +{
+    +        if (--obj->refcnt == 0)
+    +                kfree(obj);
+    +}
+    +
+    +static void __object_get(struct object *obj)
+    +{
+    +        obj->refcnt++;
+    +}
+    +
+    +void object_put(struct object *obj)
+    +{
+    +        unsigned long flags;
+    +
+    +        spin_lock_irqsave(&cache_lock, flags);
+    +        __object_put(obj);
+    +        spin_unlock_irqrestore(&cache_lock, flags);
+    +}
+    +
+    +void object_get(struct object *obj)
+    +{
+    +        unsigned long flags;
+    +
+    +        spin_lock_irqsave(&cache_lock, flags);
+    +        __object_get(obj);
+    +        spin_unlock_irqrestore(&cache_lock, flags);
+    +}
+    +
+     /* Must be holding cache_lock */
+     static struct object *__cache_find(int id)
+     {
+    @@ -35,6 +65,7 @@
+     {
+             BUG_ON(!obj);
+             list_del(&obj->list);
+    +        __object_put(obj);
+             cache_num--;
+     }
+
+    @@ -63,6 +94,7 @@
+             strlcpy(obj->name, name, sizeof(obj->name));
+             obj->id = id;
+             obj->popularity = 0;
+    +        obj->refcnt = 1; /* The cache holds a reference */
+
+             spin_lock_irqsave(&cache_lock, flags);
+             __cache_add(obj);
+    @@ -79,18 +111,15 @@
+             spin_unlock_irqrestore(&cache_lock, flags);
+     }
+
+    -int cache_find(int id, char *name)
+    +struct object *cache_find(int id)
+     {
+             struct object *obj;
+    -        int ret = -ENOENT;
+             unsigned long flags;
+
+             spin_lock_irqsave(&cache_lock, flags);
+             obj = __cache_find(id);
+    -        if (obj) {
+    -                ret = 0;
+    -                strcpy(name, obj->name);
+    -        }
+    +        if (obj)
+    +                __object_get(obj);
+             spin_unlock_irqrestore(&cache_lock, flags);
+    -        return ret;
+    +        return obj;
+     }
+
+Abbiamo incapsulato il contatore di riferimenti nelle tipiche funzioni
+di 'get' e 'put'. Ora possiamo ritornare l'oggetto da :c:func:`cache_find()`
+col vantaggio che l'utente può dormire trattenendo l'oggetto (per esempio,
+:c:func:`copy_to_user()` per copiare il nome verso lo spazio utente).
+
+Un altro punto da notare è che ho detto che il contatore dovrebbe incrementarsi
+per ogni puntatore ad un oggetto: quindi il contatore di riferimenti è 1
+quando l'oggetto viene inserito nella memoria. In altre versione il framework
+non trattiene un riferimento per se, ma diventa più complicato.
+
+Usare operazioni atomiche per il contatore di riferimenti
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+In sostanza, :c:type:`atomic_t` viene usato come contatore di riferimenti.
+Ci sono un certo numbero di operazioni atomiche definite
+in ``include/asm/atomic.h``: queste sono garantite come atomiche su qualsiasi
+processore del sistema, quindi non sono necessari i *lock*. In questo caso è
+più semplice rispetto all'uso degli spinlock, benché l'uso degli spinlock
+sia più elegante per casi non banali. Le funzioni :c:func:`atomic_inc()` e
+:c:func:`atomic_dec_and_test()` vengono usate al posto dei tipici operatori di
+incremento e decremento, e i *lock* non sono più necessari per proteggere il
+contatore stesso.
+
+::
+
+    --- cache.c.refcnt  2003-12-09 15:00:35.000000000 +1100
+    +++ cache.c.refcnt-atomic   2003-12-11 15:49:42.000000000 +1100
+    @@ -7,7 +7,7 @@
+     struct object
+     {
+             struct list_head list;
+    -        unsigned int refcnt;
+    +        atomic_t refcnt;
+             int id;
+             char name[32];
+             int popularity;
+    @@ -18,33 +18,15 @@
+     static unsigned int cache_num = 0;
+     #define MAX_CACHE_SIZE 10
+
+    -static void __object_put(struct object *obj)
+    -{
+    -        if (--obj->refcnt == 0)
+    -                kfree(obj);
+    -}
+    -
+    -static void __object_get(struct object *obj)
+    -{
+    -        obj->refcnt++;
+    -}
+    -
+     void object_put(struct object *obj)
+     {
+    -        unsigned long flags;
+    -
+    -        spin_lock_irqsave(&cache_lock, flags);
+    -        __object_put(obj);
+    -        spin_unlock_irqrestore(&cache_lock, flags);
+    +        if (atomic_dec_and_test(&obj->refcnt))
+    +                kfree(obj);
+     }
+
+     void object_get(struct object *obj)
+     {
+    -        unsigned long flags;
+    -
+    -        spin_lock_irqsave(&cache_lock, flags);
+    -        __object_get(obj);
+    -        spin_unlock_irqrestore(&cache_lock, flags);
+    +        atomic_inc(&obj->refcnt);
+     }
+
+     /* Must be holding cache_lock */
+    @@ -65,7 +47,7 @@
+     {
+             BUG_ON(!obj);
+             list_del(&obj->list);
+    -        __object_put(obj);
+    +        object_put(obj);
+             cache_num--;
+     }
+
+    @@ -94,7 +76,7 @@
+             strlcpy(obj->name, name, sizeof(obj->name));
+             obj->id = id;
+             obj->popularity = 0;
+    -        obj->refcnt = 1; /* The cache holds a reference */
+    +        atomic_set(&obj->refcnt, 1); /* The cache holds a reference */
+
+             spin_lock_irqsave(&cache_lock, flags);
+             __cache_add(obj);
+    @@ -119,7 +101,7 @@
+             spin_lock_irqsave(&cache_lock, flags);
+             obj = __cache_find(id);
+             if (obj)
+    -                __object_get(obj);
+    +                object_get(obj);
+             spin_unlock_irqrestore(&cache_lock, flags);
+             return obj;
+     }
+
+Proteggere l'oggetto stesso
+---------------------------
+
+In questo esempio, assumiamo che gli oggetti (ad eccezione del contatore
+di riferimenti) non cambino mai dopo la loro creazione. Se vogliamo permettere
+al nome di cambiare abbiamo tre possibilità:
+
+-  Si può togliere static da ``cache_lock`` e dire agli utenti che devono
+   trattenere il *lock* prima di modificare il nome di un oggetto.
+
+-  Si può fornire una funzione :c:func:`cache_obj_rename()` che prende il
+   *lock* e cambia il nome per conto del chiamante; si dirà poi agli utenti
+   di usare questa funzione.
+
+-  Si può decidere che ``cache_lock`` protegge solo la memoria stessa, ed
+   un altro *lock* è necessario per la protezione del nome.
+
+Teoricamente, possiamo avere un *lock* per ogni campo e per ogni oggetto.
+In pratica, le varianti più comuni sono:
+
+-  un *lock* che protegge l'infrastruttura (la lista ``cache`` di questo
+   esempio) e gli oggetti. Questo è quello che abbiamo fatto finora.
+
+-  un *lock* che protegge l'infrastruttura (inclusi i puntatori alla lista
+   negli oggetti), e un *lock* nell'oggetto per proteggere il resto
+   dell'oggetto stesso.
+
+-  *lock* multipli per proteggere l'infrastruttura (per esempio un *lock*
+   per ogni lista), possibilmente con un *lock* per oggetto.
+
+Qui di seguito un'implementazione con "un lock per oggetto":
+
+::
+
+    --- cache.c.refcnt-atomic   2003-12-11 15:50:54.000000000 +1100
+    +++ cache.c.perobjectlock   2003-12-11 17:15:03.000000000 +1100
+    @@ -6,11 +6,17 @@
+
+     struct object
+     {
+    +        /* These two protected by cache_lock. */
+             struct list_head list;
+    +        int popularity;
+    +
+             atomic_t refcnt;
+    +
+    +        /* Doesn't change once created. */
+             int id;
+    +
+    +        spinlock_t lock; /* Protects the name */
+             char name[32];
+    -        int popularity;
+     };
+
+     static DEFINE_SPINLOCK(cache_lock);
+    @@ -77,6 +84,7 @@
+             obj->id = id;
+             obj->popularity = 0;
+             atomic_set(&obj->refcnt, 1); /* The cache holds a reference */
+    +        spin_lock_init(&obj->lock);
+
+             spin_lock_irqsave(&cache_lock, flags);
+             __cache_add(obj);
+
+Da notare che ho deciso che il contatore di popolarità dovesse essere
+protetto da ``cache_lock`` piuttosto che dal *lock* dell'oggetto; questo
+perché è logicamente parte dell'infrastruttura (come
+:c:type:`struct list_head <list_head>` nell'oggetto). In questo modo,
+in :c:func:`__cache_add()`, non ho bisogno di trattenere il *lock* di ogni
+oggetto mentre si cerca il meno popolare.
+
+Ho anche deciso che il campo id è immutabile, quindi non ho bisogno di
+trattenere il lock dell'oggetto quando si usa :c:func:`__cache_find()`
+per leggere questo campo; il *lock* dell'oggetto è usato solo dal chiamante
+che vuole leggere o scrivere il campo name.
+
+Inoltre, da notare che ho aggiunto un commento che descrive i dati che sono
+protetti dal *lock*. Questo è estremamente importante in quanto descrive il
+comportamento del codice, che altrimenti sarebbe di difficile comprensione
+leggendo solamente il codice. E come dice Alan Cox: “Lock data, not code”.
+
+Problemi comuni
+===============
+
+.. _`it_deadlock`:
+
+Stallo: semplice ed avanzato
+----------------------------
+
+Esiste un tipo di  baco dove un pezzo di codice tenta di trattenere uno
+spinlock due volte: questo rimarrà in attesa attiva per sempre aspettando che
+il *lock* venga rilasciato (in Linux spinlocks, rwlocks e mutex non sono
+ricorsivi).
+Questo è facile da diagnosticare: non è uno di quei problemi che ti tengono
+sveglio 5 notti a parlare da solo.
+
+Un caso un pochino più complesso; immaginate d'avere una spazio condiviso
+fra un softirq ed il contesto utente. Se usate :c:func:`spin_lock()` per
+proteggerlo, il contesto utente potrebbe essere interrotto da un softirq
+mentre trattiene il lock, da qui il softirq rimarrà in attesa attiva provando
+ad acquisire il *lock* già trattenuto nel contesto utente.
+
+Questi casi sono chiamati stalli (*deadlock*), e come mostrato qui sopra,
+può succedere anche con un solo processore (Ma non sui sistemi
+monoprocessore perché gli spinlock spariscano quando il kernel è compilato
+con ``CONFIG_SMP``\ =n. Nonostante ciò, nel secondo caso avrete comunque
+una corruzione dei dati).
+
+Questi casi sono facili da diagnosticare; sui sistemi multi-processore
+il supervisione (*watchdog*) o l'opzione di compilazione ``DEBUG_SPINLOCK``
+(``include/linux/spinlock.h``) permettono di scovare immediatamente quando
+succedono.
+
+Esiste un caso più complesso che è conosciuto come l'abbraccio della morte;
+questo coinvolge due o più *lock*. Diciamo che avete un vettore di hash in cui
+ogni elemento è uno spinlock a cui è associata una lista di elementi con lo
+stesso hash. In un gestore di interruzioni software, dovete modificare un
+oggetto e spostarlo su un altro hash; quindi dovrete trattenete lo spinlock
+del vecchio hash e di quello nuovo, quindi rimuovere l'oggetto dal vecchio ed
+inserirlo nel nuovo.
+
+Qui abbiamo due problemi. Primo, se il vostro codice prova a spostare un
+oggetto all'interno della stessa lista, otterrete uno stallo visto che
+tenterà di trattenere lo stesso *lock* due volte. Secondo, se la stessa
+interruzione software su un altro processore sta tentando di spostare
+un altro oggetto nella direzione opposta, potrebbe accadere quanto segue:
+
++---------------------------------+---------------------------------+
+| CPU 1                           | CPU 2                           |
++=================================+=================================+
+| Trattiene *lock* A -> OK        | Trattiene *lock* B -> OK        |
++---------------------------------+---------------------------------+
+| Trattiene *lock* B -> attesa    | Trattiene *lock* A -> attesa    |
++---------------------------------+---------------------------------+
+
+Table: Conseguenze
+
+Entrambe i processori rimarranno in attesa attiva sul *lock* per sempre,
+aspettando che l'altro lo rilasci. Sembra e puzza come un blocco totale.
+
+Prevenire gli stalli
+--------------------
+
+I libri di testo vi diranno che se trattenete i *lock* sempre nello stesso
+ordine non avrete mai un simile stallo. La pratica vi dirà che questo
+approccio non funziona all'ingrandirsi del sistema: quando creo un nuovo
+*lock* non ne capisco abbastanza del kernel per dire in quale dei 5000 *lock*
+si incastrerà.
+
+I *lock* migliori sono quelli incapsulati: non vengono esposti nei file di
+intestazione, e non vengono mai trattenuti fuori dallo stesso file. Potete
+rileggere questo codice e vedere che non ci sarà mai uno stallo perché
+non tenterà mai di trattenere un altro *lock* quando lo ha già.
+Le persone che usano il vostro codice non devono nemmeno sapere che voi
+state usando dei *lock*.
+
+Un classico problema deriva dall'uso di *callback* e di *hook*: se li
+chiamate mentre trattenete un *lock*, rischiate uno stallo o un abbraccio
+della morte (chi lo sa cosa farà una *callback*?).
+
+Ossessiva prevenzione degli stalli
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Gli stalli sono un problema, ma non così terribile come la corruzione dei dati.
+Un pezzo di codice trattiene un *lock* di lettura, cerca in una lista,
+fallisce nel trovare quello che vuole, quindi rilascia il *lock* di lettura,
+trattiene un *lock* di scrittura ed inserisce un oggetto; questo genere di
+codice presenta una corsa critica.
+
+Se non riuscite a capire il perché, per favore state alla larga dal mio
+codice.
+
+corsa fra temporizzatori: un passatempo del kernel
+--------------------------------------------------
+
+I temporizzatori potrebbero avere dei problemi con le corse critiche.
+Considerate una collezione di oggetti (liste, hash, eccetera) dove ogni oggetto
+ha un temporizzatore che sta per distruggerlo.
+
+Se volete eliminare l'intera collezione (diciamo quando rimuovete un modulo),
+potreste fare come segue::
+
+            /* THIS CODE BAD BAD BAD BAD: IF IT WAS ANY WORSE IT WOULD USE
+               HUNGARIAN NOTATION */
+            spin_lock_bh(&list_lock);
+
+            while (list) {
+                    struct foo *next = list->next;
+                    del_timer(&list->timer);
+                    kfree(list);
+                    list = next;
+            }
+
+            spin_unlock_bh(&list_lock);
+
+Primo o poi, questo esploderà su un sistema multiprocessore perché un
+temporizzatore potrebbe essere già partiro prima di :c:func:`spin_lock_bh()`,
+e prenderà il *lock* solo dopo :c:func:`spin_unlock_bh()`, e cercherà
+di eliminare il suo oggetto (che però è già stato eliminato).
+
+Questo può essere evitato controllando il valore di ritorno di
+:c:func:`del_timer()`: se ritorna 1, il temporizzatore è stato già
+rimosso. Se 0, significa (in questo caso) che il temporizzatore è in
+esecuzione, quindi possiamo fare come segue::
+
+            retry:
+                    spin_lock_bh(&list_lock);
+
+                    while (list) {
+                            struct foo *next = list->next;
+                            if (!del_timer(&list->timer)) {
+                                    /* Give timer a chance to delete this */
+                                    spin_unlock_bh(&list_lock);
+                                    goto retry;
+                            }
+                            kfree(list);
+                            list = next;
+                    }
+
+                    spin_unlock_bh(&list_lock);
+
+Un altro problema è l'eliminazione dei temporizzatori che si riavviano
+da soli (chiamando :c:func:`add_timer()` alla fine della loro esecuzione).
+Dato che questo è un problema abbastanza comune con una propensione
+alle corse critiche, dovreste usare :c:func:`del_timer_sync()`
+(``include/linux/timer.h``) per gestire questo caso. Questa ritorna il
+numero di volte che il temporizzatore è stato interrotto prima che
+fosse in grado di fermarlo senza che si riavviasse.
+
+Velocità della sincronizzazione
+===============================
+
+Ci sono tre cose importanti da tenere in considerazione quando si valuta
+la velocità d'esecuzione di un pezzo di codice che necessita di
+sincronizzazione. La prima è la concorrenza: quante cose rimangono in attesa
+mentre qualcuno trattiene un *lock*. La seconda è il tempo necessario per
+acquisire (senza contese) e rilasciare un *lock*. La terza è di usare meno
+*lock* o di più furbi. Immagino che i *lock* vengano usati regolarmente,
+altrimenti, non sareste interessati all'efficienza.
+
+La concorrenza dipende da quanto a lungo un *lock* è trattenuto: dovreste
+trattenere un *lock* solo il tempo minimo necessario ma non un istante in più.
+Nella memoria dell'esempio precedente, creiamo gli oggetti senza trattenere
+il *lock*, poi acquisiamo il *lock* quando siamo pronti per inserirlo nella
+lista.
+
+Il tempo di acquisizione di un *lock* dipende da quanto danno fa
+l'operazione sulla *pipeline* (ovvero stalli della *pipeline*) e quant'è
+probabile che il processore corrente sia stato anche l'ultimo ad acquisire
+il *lock* (in pratica, il *lock* è nella memoria cache del processore
+corrente?): su sistemi multi-processore questa probabilità precipita
+rapidamente. Consideriamo un processore Intel Pentium III a 700Mhz: questo
+esegue un'istruzione in 0.7ns, un incremento atomico richiede 58ns, acquisire
+un *lock* che è nella memoria cache del processore richiede 160ns, e un
+trasferimento dalla memoria cache di un altro processore richiede altri
+170/360ns (Leggetevi l'articolo di Paul McKenney's `Linux Journal RCU
+article <http://www.linuxjournal.com/article.php?sid=6993>`__).
+
+Questi due obiettivi sono in conflitto: trattenere un *lock* per il minor
+tempo possibile potrebbe richiedere la divisione in più *lock* per diverse
+parti (come nel nostro ultimo esempio con un *lock* per ogni oggetto),
+ma questo aumenta il numero di acquisizioni di *lock*, ed il risultato
+spesso è che tutto è più lento che con un singolo *lock*. Questo è un altro
+argomento in favore della semplicità quando si parla di sincronizzazione.
+
+Il terzo punto è discusso di seguito: ci sono alcune tecniche per ridurre
+il numero di sincronizzazioni che devono essere fatte.
+
+Read/Write Lock Variants
+------------------------
+
+Sia gli spinlock che i mutex hanno una variante per la lettura/scrittura
+(read/write): ``rwlock_t`` e :c:type:`struct rw_semaphore <rw_semaphore>`.
+Queste dividono gli utenti in due categorie: i lettori e gli scrittori.
+Se state solo leggendo i dati, potete acquisire il *lock* di lettura, ma
+per scrivere avrete bisogno del *lock* di scrittura. Molti possono trattenere
+il *lock* di lettura, ma solo uno scrittore alla volta può trattenere
+quello di scrittura.
+
+Se il vostro codice si divide chiaramente in codice per lettori e codice
+per scrittori (come nel nostro esempio), e il *lock* dei lettori viene
+trattenuto per molto tempo, allora l'uso di questo tipo di *lock* può aiutare.
+Questi sono leggermente più lenti rispetto alla loro versione normale, quindi
+nella pratica l'uso di ``rwlock_t`` non ne vale la pena.
+
+Evitare i *lock*: Read Copy Update
+--------------------------------------------
+
+Esiste un metodo di sincronizzazione per letture e scritture detto
+Read Copy Update. Con l'uso della tecnica RCU, i lettori possono scordarsi
+completamente di trattenere i *lock*; dato che nel nostro esempio ci
+aspettiamo d'avere più lettore che scrittori (altrimenti questa memoria
+sarebbe uno spreco) possiamo dire che questo meccanismo permette
+un'ottimizzazione.
+
+Come facciamo a sbarazzarci dei *lock* di lettura? Sbarazzarsi dei *lock* di
+lettura significa che uno scrittore potrebbe cambiare la lista sotto al naso
+dei lettori. Questo è abbastanza semplice: possiamo leggere una lista
+concatenata se lo scrittore aggiunge elementi alla fine e con certe
+precauzioni. Per esempio, aggiungendo ``new`` ad una lista concatenata
+chiamata ``list``::
+
+            new->next = list->next;
+            wmb();
+            list->next = new;
+
+La funzione :c:func:`wmb()` è una barriera di sincronizzazione delle
+scritture. Questa garantisce che la prima operazione (impostare l'elemento
+``next`` del nuovo elemento) venga completata e vista da tutti i processori
+prima che venga eseguita la seconda operazione (che sarebbe quella di mettere
+il nuovo elemento nella lista). Questo è importante perché i moderni
+compilatori ed i moderni processori possono, entrambe, riordinare le istruzioni
+se non vengono istruiti altrimenti: vogliamo che i lettori non vedano
+completamente il nuovo elemento; oppure che lo vedano correttamente e quindi
+il puntatore ``next`` deve puntare al resto della lista.
+
+Fortunatamente, c'è una funzione che fa questa operazione sulle liste
+:c:type:`struct list_head <list_head>`: :c:func:`list_add_rcu()`
+(``include/linux/list.h``).
+
+Rimuovere un elemento dalla lista è anche più facile: sostituiamo il puntatore
+al vecchio elemento con quello del suo successore, e i lettori vedranno
+l'elemento o lo salteranno.
+
+::
+
+            list->next = old->next;
+
+La funzione :c:func:`list_del_rcu()` (``include/linux/list.h``) fa esattamente
+questo (la versione normale corrompe il vecchio oggetto, e non vogliamo che
+accada).
+
+Anche i lettori devono stare attenti: alcuni processori potrebbero leggere
+attraverso il puntatore ``next`` il contenuto dell'elemento successivo
+troppo presto, ma non accorgersi che il contenuto caricato è sbagliato quando
+il puntatore ``next`` viene modificato alla loro spalle. Ancora una volta
+c'è una funzione che viene in vostro aiuto :c:func:`list_for_each_entry_rcu()`
+(``include/linux/list.h``). Ovviamente, gli scrittori possono usare
+:c:func:`list_for_each_entry()` dato che non ci possono essere due scrittori
+in contemporanea.
+
+Il nostro ultimo dilemma è il seguente: quando possiamo realmente distruggere
+l'elemento rimosso? Ricordate, un lettore potrebbe aver avuto accesso a questo
+elemento proprio ora: se eliminiamo questo elemento ed il puntatore ``next``
+cambia, il lettore salterà direttamente nella spazzatura e scoppierà. Dobbiamo
+aspettare finché tutti i lettori che stanno attraversando la lista abbiano
+finito. Utilizziamo :c:func:`call_rcu()` per registrare una funzione di
+richiamo che distrugga l'oggetto quando tutti i lettori correnti hanno
+terminato. In alternative, potrebbe essere usata la funzione
+:c:func:`synchronize_rcu()` che blocca l'esecuzione finché tutti i lettori
+non terminano di ispezionare la lista.
+
+Ma come fa l'RCU a sapere quando i lettori sono finiti? Il meccanismo è
+il seguente: innanzi tutto i lettori accedono alla lista solo fra la coppia
+:c:func:`rcu_read_lock()`/:c:func:`rcu_read_unlock()` che disabilita la
+prelazione così che i lettori non vengano sospesi mentre stanno leggendo
+la lista.
+
+Poi, l'RCU aspetta finché tutti i processori non abbiano dormito almeno
+una volta; a questo punto, dato che i lettori non possono dormire, possiamo
+dedurre che un qualsiasi lettore che abbia consultato la lista durante la
+rimozione abbia già terminato, quindi la *callback* viene eseguita. Il vero
+codice RCU è un po' più ottimizzato di così, ma questa è l'idea di fondo.
+
+::
+
+    --- cache.c.perobjectlock   2003-12-11 17:15:03.000000000 +1100
+    +++ cache.c.rcupdate    2003-12-11 17:55:14.000000000 +1100
+    @@ -1,15 +1,18 @@
+     #include <linux/list.h>
+     #include <linux/slab.h>
+     #include <linux/string.h>
+    +#include <linux/rcupdate.h>
+     #include <linux/mutex.h>
+     #include <asm/errno.h>
+
+     struct object
+     {
+    -        /* These two protected by cache_lock. */
+    +        /* This is protected by RCU */
+             struct list_head list;
+             int popularity;
+
+    +        struct rcu_head rcu;
+    +
+             atomic_t refcnt;
+
+             /* Doesn't change once created. */
+    @@ -40,7 +43,7 @@
+     {
+             struct object *i;
+
+    -        list_for_each_entry(i, &cache, list) {
+    +        list_for_each_entry_rcu(i, &cache, list) {
+                     if (i->id == id) {
+                             i->popularity++;
+                             return i;
+    @@ -49,19 +52,25 @@
+             return NULL;
+     }
+
+    +/* Final discard done once we know no readers are looking. */
+    +static void cache_delete_rcu(void *arg)
+    +{
+    +        object_put(arg);
+    +}
+    +
+     /* Must be holding cache_lock */
+     static void __cache_delete(struct object *obj)
+     {
+             BUG_ON(!obj);
+    -        list_del(&obj->list);
+    -        object_put(obj);
+    +        list_del_rcu(&obj->list);
+             cache_num--;
+    +        call_rcu(&obj->rcu, cache_delete_rcu);
+     }
+
+     /* Must be holding cache_lock */
+     static void __cache_add(struct object *obj)
+     {
+    -        list_add(&obj->list, &cache);
+    +        list_add_rcu(&obj->list, &cache);
+             if (++cache_num > MAX_CACHE_SIZE) {
+                     struct object *i, *outcast = NULL;
+                     list_for_each_entry(i, &cache, list) {
+    @@ -104,12 +114,11 @@
+     struct object *cache_find(int id)
+     {
+             struct object *obj;
+    -        unsigned long flags;
+
+    -        spin_lock_irqsave(&cache_lock, flags);
+    +        rcu_read_lock();
+             obj = __cache_find(id);
+             if (obj)
+                     object_get(obj);
+    -        spin_unlock_irqrestore(&cache_lock, flags);
+    +        rcu_read_unlock();
+             return obj;
+     }
+
+Da notare che i lettori modificano il campo popularity nella funzione
+:c:func:`__cache_find()`, e ora non trattiene alcun *lock*. Una soluzione
+potrebbe essere quella di rendere la variabile ``atomic_t``, ma per l'uso
+che ne abbiamo fatto qui, non ci interessano queste corse critiche perché un
+risultato approssimativo è comunque accettabile, quindi non l'ho cambiato.
+
+Il risultato è che la funzione :c:func:`cache_find()` non ha bisogno di alcuna
+sincronizzazione con le altre funzioni, quindi è veloce su un sistema
+multi-processore tanto quanto lo sarebbe su un sistema mono-processore.
+
+Esiste un'ulteriore ottimizzazione possibile: vi ricordate il codice originale
+della nostra memoria dove non c'erano contatori di riferimenti e il chiamante
+semplicemente tratteneva il *lock* prima di accedere ad un oggetto? Questo è
+ancora possibile: se trattenete un *lock* nessuno potrà cancellare l'oggetto,
+quindi non avete bisogno di incrementare e decrementare il contatore di
+riferimenti.
+
+Ora, dato che il '*lock* di lettura' di un RCU non fa altro che disabilitare
+la prelazione, un chiamante che ha sempre la prelazione disabilitata fra le
+chiamate :c:func:`cache_find()` e :c:func:`object_put()` non necessita
+di incrementare e decrementare il contatore di riferimenti. Potremmo
+esporre la funzione :c:func:`__cache_find()` dichiarandola non-static,
+e quel chiamante potrebbe usare direttamente questa funzione.
+
+Il beneficio qui sta nel fatto che il contatore di riferimenti no
+viene scritto: l'oggetto non viene alterato in alcun modo e quindi diventa
+molto più veloce su sistemi molti-processore grazie alla loro memoria cache.
+
+.. _`it_per-cpu`:
+
+Dati per processore
+-------------------
+
+Un'altra tecnica comunemente usata per evitare la sincronizzazione è quella
+di duplicare le informazioni per ogni processore. Per esempio, se volete
+avere un contatore di qualcosa, potreste utilizzare uno spinlock ed un
+singolo contatore. Facile e pulito.
+
+Se questo dovesse essere troppo lento (solitamente non lo è, ma se avete
+dimostrato che lo è devvero), potreste usare un contatore per ogni processore
+e quindi non sarebbe più necessaria la mutua esclusione. Vedere
+:c:func:`DEFINE_PER_CPU()`, :c:func:`get_cpu_var()` e :c:func:`put_cpu_var()`
+(``include/linux/percpu.h``).
+
+Il tipo di dato ``local_t``, la funzione :c:func:`cpu_local_inc()` e tutte
+le altre funzioni associate, sono di particolare utilità per semplici contatori
+per-processore; su alcune architetture sono anche più efficienti
+(``include/asm/local.h``).
+
+Da notare che non esiste un modo facile ed affidabile per ottenere il valore
+di un simile contatore senza introdurre altri *lock*. In alcuni casi questo
+non è un problema.
+
+Dati che sono usati prevalentemente dai gestori d'interruzioni
+--------------------------------------------------------------
+
+Se i dati vengono utilizzati sempre dallo stesso gestore d'interruzioni,
+allora i *lock* non vi servono per niente: il kernel già vi garantisce che
+il gestore d'interruzione non verrà eseguito in contemporanea su diversi
+processori.
+
+Manfred Spraul fa notare che potreste comunque comportarvi così anche
+se i dati vengono occasionalmente utilizzati da un contesto utente o
+da un'interruzione software. Il gestore d'interruzione non utilizza alcun
+*lock*, e tutti gli altri accessi verranno fatti così::
+
+        spin_lock(&lock);
+        disable_irq(irq);
+        ...
+        enable_irq(irq);
+        spin_unlock(&lock);
+
+La funzione :c:func:`disable_irq()` impedisce al gestore d'interruzioni
+d'essere eseguito (e aspetta che finisca nel caso fosse in esecuzione su
+un altro processore). Lo spinlock, invece, previene accessi simultanei.
+Naturalmente, questo è più lento della semplice chiamata
+:c:func:`spin_lock_irq()`, quindi ha senso solo se questo genere di accesso
+è estremamente raro.
+
+.. _`it_sleeping-things`:
+
+Quali funzioni possono essere chiamate in modo sicuro dalle interruzioni?
+=========================================================================
+
+Molte funzioni del kernel dormono (in sostanza, chiamano ``schedule()``)
+direttamente od indirettamente: non potete chiamarle se trattenere uno
+spinlock o avete la prelazione disabilitata, mai. Questo significa che
+dovete necessariamente essere nel contesto utente: chiamarle da un
+contesto d'interruzione è illegale.
+
+Alcune funzioni che dormono
+---------------------------
+
+Le più comuni sono elencate qui di seguito, ma solitamente dovete leggere
+il codice per scoprire se altre chiamate sono sicure. Se chiunque altro
+le chiami dorme, allora dovreste poter dormire anche voi. In particolar
+modo, le funzioni di registrazione e deregistrazione solitamente si
+aspettano d'essere chiamante da un contesto utente e quindi che possono
+dormire.
+
+-  Accessi allo spazio utente:
+
+   -  :c:func:`copy_from_user()`
+
+   -  :c:func:`copy_to_user()`
+
+   -  :c:func:`get_user()`
+
+   -  :c:func:`put_user()`
+
+-  :c:func:`kmalloc(GFP_KERNEL) <kmalloc>`
+
+-  :c:func:`mutex_lock_interruptible()` and
+   :c:func:`mutex_lock()`
+
+   C'è anche :c:func:`mutex_trylock()` che però non dorme.
+   Comunque, non deve essere usata in un contesto d'interruzione dato
+   che la sua implementazione non è sicura in quel contesto.
+   Anche :c:func:`mutex_unlock()` non dorme mai. Non può comunque essere
+   usata in un contesto d'interruzione perché un mutex deve essere rilasciato
+   dallo stesso processo che l'ha acquisito.
+
+Alcune funzioni che non dormono
+-------------------------------
+
+Alcune funzioni possono essere chiamate tranquillamente da qualsiasi
+contesto, o trattenendo un qualsiasi *lock*.
+
+-  :c:func:`printk()`
+
+-  :c:func:`kfree()`
+
+-  :c:func:`add_timer()` e :c:func:`del_timer()`
+
+Riferimento per l'API dei Mutex
+===============================
+
+.. kernel-doc:: include/linux/mutex.h
+   :internal:
+
+.. kernel-doc:: kernel/locking/mutex.c
+   :export:
+
+Riferimento per l'API dei Futex
+===============================
+
+.. kernel-doc:: kernel/futex.c
+   :internal:
+
+Approfondimenti
+===============
+
+-  ``Documentation/locking/spinlocks.txt``: la guida di Linus Torvalds agli
+   spinlock del kernel.
+
+-  Unix Systems for Modern Architectures: Symmetric Multiprocessing and
+   Caching for Kernel Programmers.
+
+   L'introduzione alla sincronizzazione a livello di kernel di Curt Schimmel
+   è davvero ottima (non è scritta per Linux, ma approssimativamente si adatta
+   a tutte le situazioni). Il libro è costoso, ma vale ogni singolo spicciolo
+   per capire la sincronizzazione nei sistemi multi-processore.
+   [ISBN: 0201633388]
+
+Ringraziamenti
+==============
+
+Grazie a Telsa Gwynne per aver formattato questa guida in DocBook, averla
+pulita e aggiunto un po' di stile.
+
+Grazie a Martin Pool, Philipp Rumpf, Stephen Rothwell, Paul Mackerras,
+Ruedi Aschwanden, Alan Cox, Manfred Spraul, Tim Waugh, Pete Zaitcev,
+James Morris, Robert Love, Paul McKenney, John Ashby per aver revisionato,
+corretto, maledetto e commentato.
+
+Grazie alla congrega per non aver avuto alcuna influenza su questo documento.
+
+Glossario
+=========
+
+prelazione
+  Prima del kernel 2.5, o quando ``CONFIG_PREEMPT`` non è impostato, i processi
+  in contesto utente non si avvicendano nell'esecuzione (in pratica, il
+  processo userà il processore fino al proprio termine, a meno che non ci siano
+  delle interruzioni). Con l'aggiunta di ``CONFIG_PREEMPT`` nella versione
+  2.5.4 questo è cambiato: quando si è in contesto utente, processi con una
+  priorità maggiore possono subentrare nell'esecuzione: gli spinlock furono
+  cambiati per disabilitare la prelazioni, anche su sistemi monoprocessore.
+
+bh
+  Bottom Half: per ragioni storiche, le funzioni che contengono '_bh' nel
+  loro nome ora si riferiscono a qualsiasi interruzione software; per esempio,
+  :c:func:`spin_lock_bh()` blocca qualsiasi interuzione software sul processore
+  corrente. I *Bottom Halves* sono deprecati, e probabilmente verranno
+  sostituiti dai tasklet. In un dato momento potrà esserci solo un
+  *bottom half* in esecuzione.
+
+contesto d'interruzione
+  Non è il contesto utente: qui si processano le interruzioni hardware e
+  software. La macro :c:func:`in_interrupt()` ritorna vero.
+
+contesto utente
+  Il kernel che esegue qualcosa per conto di un particolare processo (per
+  esempio una chiamata di sistema) o di un thread del kernel. Potete
+  identificare il processo con la macro ``current``. Da non confondere
+  con lo spazio utente. Può essere interrotto sia da interruzioni software
+  che hardware.
+
+interruzione hardware
+  Richiesta di interruzione hardware. :c:func:`in_irq()` ritorna vero in un
+  gestore d'interruzioni hardware.
+
+interruzione software / softirq
+  Gestore di interruzioni software: :c:func:`in_irq()` ritorna falso;
+  :c:func:`in_softirq()` ritorna vero. I tasklet e le softirq sono entrambi
+  considerati 'interruzioni software'.
+
+  In soldoni, un softirq è uno delle 32 interruzioni software che possono
+  essere eseguite su più processori in contemporanea. A volte si usa per
+  riferirsi anche ai tasklet (in pratica tutte le interruzioni software).
+
+monoprocessore / UP
+  (Uni-Processor) un solo processore, ovvero non è SMP. (``CONFIG_SMP=n``).
+
+multi-processore / SMP
+  (Symmetric Multi-Processor) kernel compilati per sistemi multi-processore
+  (``CONFIG_SMP=y``).
+
+spazio utente
+  Un processo che esegue il proprio codice fuori dal kernel.
+
+tasklet
+  Un'interruzione software registrabile dinamicamente che ha la garanzia
+  d'essere eseguita solo su un processore alla volta.
+
+timer
+  Un'interruzione software registrabile dinamicamente che viene eseguita
+  (circa) in un determinato momento. Quando è in esecuzione è come un tasklet
+  (infatti, sono chiamati da ``TIMER_SOFTIRQ``).
-- 
2.17.1

