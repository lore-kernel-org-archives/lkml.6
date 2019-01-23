Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32976C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41A4218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="5EDDlqTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfAWUXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:23:22 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:35008 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbfAWUXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:23:22 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id E5A95658;
        Wed, 23 Jan 2019 21:23:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1548274997; x=1550089398;
         bh=pPaA/6PU9D8RLaJ3eAVllinKWh+K6DClev5miX+hjCo=; b=5EDDlqTKcePT
        LUBwxZFSTVckO1Fct05mnQYw51/FB/0H7f0bVn0ajORmihlDgN8kxriUtj5Q0b+w
        7MA4FwDGV+Bay1pJhldR5ScllugpuOOAdRsyDaduQxgzSvx2jWXKrj4sjWHGj9ut
        ee/+QeoGP3aaNkgT/CSwguzfQNDxcjzbmucXs8S5ieV+zbnJdAjGDcz6X5XgRcqT
        y73lTUGnEWUUmG+kjB+WHxK2+aCdVLPDyNHS/fGlNGt4ahANs7jjHbSlsf6Xo4h+
        7wKRjngroYBVVlln0+tTlY6A/66JGMBFwrj6QODuARvkYHYbaXsAznXVNA/FIKFb
        spPUWHITqWMdcQXXbg0XfuheyUJmHh/sOSLvFgZVySoR2iT4U2fleITaNxsM9ChL
        6I2P5YvLASXNKw5j4OUj1RfRo8QCVL7HjGtZrOMX7r8Uh6S9ZgiX2cTtMe/D70k2
        u7CaB0PBiDR+sHNEQl78HpwLOcVEVVliNM0Dp9Jdh4NJio921JZhYCDOahfFjbOO
        MBKsatChVOlsWqojoJbVpMf1/u2nTYlaazMpsHES31hY26VzLWcQKMqJm165Voph
        y1rdzGDXJ9ytJ2WPuj5Jw1No+cqZ+/ZtVlrK+B34/VTLTI1B/O3LfMtAYsbVUusL
        uKudwyUAyM05BtTZbPJvC0MiuDT71eM=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NgeO-eEFlnhv; Wed, 23 Jan 2019 21:23:17 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id A3ED0B6;
        Wed, 23 Jan 2019 21:23:17 +0100 (CET)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 3BAC325A6;
        Wed, 23 Jan 2019 21:23:17 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] doc:it_IT: update coding-style - expectations around bool
Date:   Wed, 23 Jan 2019 21:22:55 +0100
Message-Id: <20190123202255.16479-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch translates in Italian the content of the following patch

7967656ffbfa coding-style: Clarify the expectations around bool

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 .../it_IT/process/coding-style.rst            | 43 ++++++++++++++++---
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/Documentation/translations/it_IT/process/coding-style.rst b/Documentation/translations/it_IT/process/coding-style.rst
index dfdefb951b89..2fd0e7f79d55 100644
--- a/Documentation/translations/it_IT/process/coding-style.rst
+++ b/Documentation/translations/it_IT/process/coding-style.rst
@@ -949,7 +949,40 @@ qualche valore fuori dai limiti.  Un tipico esempio è quello delle funzioni
 che ritornano un puntatore; queste utilizzano NULL o ERR_PTR come meccanismo
 di notifica degli errori.
 
-17) Non reinventate le macro del kernel
+17) L'uso di bool
+-----------------
+
+Nel kernel Linux il tipo bool deriva dal tipo _Bool dello standard C99.
+Un valore bool può assumere solo i valori 0 o 1, e implicitamente o
+esplicitamente la conversione a bool converte i valori in vero (*true*) o
+falso (*false*).  Quando si usa un tipo bool il costrutto !! non sarà più
+necessario, e questo va ad eliminare una certa serie di bachi.
+
+Quando si usano i valori booleani, dovreste utilizzare le definizioni di true
+e false al posto dei valori 1 e 0.
+
+Per il valore di ritorno delle funzioni e per le variabili sullo stack, l'uso
+del tipo bool è sempre appropriato.  L'uso di bool viene incoraggiato per
+migliorare la leggibilità e spesso è molto meglio di 'int' nella gestione di
+valori booleani.
+
+Non usate bool se per voi sono importanti l'ordine delle righe di cache o
+la loro dimensione; la dimensione e l'allineamento cambia a seconda
+dell'architettura per la quale è stato compilato.  Le strutture che sono state
+ottimizzate per l'allineamento o la dimensione non dovrebbero usare bool.
+
+Se una struttura ha molti valori true/false, considerate l'idea di raggrupparli
+in un intero usando campi da 1 bit, oppure usate un tipo dalla larghezza fissa,
+come u8.
+
+Come per gli argomenti delle funzioni, molti valori true/false possono essere
+raggruppati in un singolo argomento a bit denominato 'flags'; spesso 'flags' è
+un'alternativa molto più leggibile se si hanno valori costanti per true/false.
+
+Detto ciò, un uso parsimonioso di bool nelle strutture dati e negli argomenti
+può migliorare la leggibilità.
+
+18) Non reinventate le macro del kernel
 ---------------------------------------
 
 Il file di intestazione include/linux/kernel.h contiene un certo numero
@@ -973,7 +1006,7 @@ rigido sui tipi.  Sentitevi liberi di leggere attentamente questo file
 d'intestazione per scoprire cos'altro è stato definito che non dovreste
 reinventare nel vostro codice.
 
-18) Linee di configurazione degli editor e altre schifezze
+19) Linee di configurazione degli editor e altre schifezze
 -----------------------------------------------------------
 
 Alcuni editor possono interpretare dei parametri di configurazione integrati
@@ -1007,8 +1040,8 @@ d'indentazione e di modalità d'uso.  Le persone potrebbero aver configurato una
 modalità su misura, oppure potrebbero avere qualche altra magia per far
 funzionare bene l'indentazione.
 
-19) Inline assembly
----------------------
+20) Inline assembly
+-------------------
 
 Nel codice specifico per un'architettura, potreste aver bisogno di codice
 *inline assembly* per interfacciarvi col processore o con una funzionalità
@@ -1040,7 +1073,7 @@ al fine di allineare correttamente l'assembler che verrà generato:
 	     "more_magic %reg2, %reg3"
 	     : /* outputs */ : /* inputs */ : /* clobbers */);
 
-20) Compilazione sotto condizione
+21) Compilazione sotto condizione
 ---------------------------------
 
 Ovunque sia possibile, non usate le direttive condizionali del preprocessore
-- 
2.20.1

