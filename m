Return-Path: <valdis@vt.edu>
X-Google-Smtp-Source: AIpwx4+oskIwDfOeOoTPLPVz/Lw3RiL7qWWgxUFJ9fl66hwOb8/VNxRNwv8ueA6bXQ9GKgXKul9i
ARC-Seal: i=1; a=rsa-sha256; t=1521657485; cv=none;
        d=google.com; s=arc-20160816;
        b=kAWzx2UcDCkcJKXWONGlI7gtFMGXNSjlXIrNJT8oIvynXx6DyJOPfqlS1F1wCyWfb9
         YAVHKjQi40WyzS8DKqk0kYsT6VXhtiqsDYPAzSR8oM1yEd6Me4vmg89DeRc4D/p3TxBj
         /Pi0qZF5UFTct3PESirafC5lger9yDfG1q5fXOkgJF2rhzPxZuSR262BQPSycWEkwfgN
         KaZS2Z38ev4F7RD14yA5FhlgHMeDthlVXKEXuUfioKLU+cvtDYC7jxppJ3DPveVuNKsr
         zyFlIelBq4arlHGD/VNTKzSg60Ujx7rCLep0ICCBy1gywHb19tQ9KmMw9+HGd2hnCesK
         e15g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:content-transfer-encoding:mime-version:references
         :in-reply-to:subject:cc:to:from:sender:arc-authentication-results;
        bh=rz6rGHgtr9zBJ6YH0IqkNJTvyaf/hSG6qXd0vFNRGAs=;
        b=H+n8WysjshiReth04GI27CPkAszJEzohzrmlPvV2P2VFJ1Fjivwa4Pw3LD/tM2n30p
         iKqG2LHoxZ4kGCSipeY0Zj9VMkT9vIp+6BWx6EB86e6bOy5MNcfzRuwxVXOp0mPTeP8n
         EEjXOK4QLyRvZ9qJlnGahzOv6T9sBJiaLu9ciE4YYfUvRtaRVDBEduR3APslb+405HVT
         IBTt8wG/8fwF3FshWozk/owZtQA7BeYbonGha7bPyQWkBcvqLqydBQilVgn236SmscRv
         b7qhI5LYiJo2qi/sTzz5eyZdPRpcELwmWt0nhbKynqcwlvsOMnCxwiWcDPf81jt3ut/y
         3YFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of valdis@vt.edu designates 2607:b400:92:8400:0:33:fb76:806e as permitted sender) smtp.mailfrom=valdis@vt.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=vt.edu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of valdis@vt.edu designates 2607:b400:92:8400:0:33:fb76:806e as permitted sender) smtp.mailfrom=valdis@vt.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=vt.edu
Sender: Valdis Kletnieks <valdis@vt.edu>
From: valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: linux-next 20180320 compile failure - tools/lib/str_error_r.c
In-Reply-To: <20180321132938.GA3749@redhat.com>
References: <40533.1521564212@turing-police.cc.vt.edu>
 <20180321132938.GA3749@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1521657477_14535P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Mar 2018 14:37:57 -0400
Message-ID: <147690.1521657477@turing-police.cc.vt.edu>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595475724335352111?=
X-GMAIL-MSGID: =?utf-8?q?1595573519763821395?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--==_Exmh_1521657477_14535P
Content-Type: text/plain; charset=us-ascii

On Wed, 21 Mar 2018 10:29:38 -0300, Arnaldo Carvalho de Melo said:
> Em Tue, Mar 20, 2018 at 12:43:32PM -0400, valdis.kletnieks@vt.edu escreveu:

> > next-20180320 with "gcc (GCC) 8.0.1 20180317 (Red Hat 8.0.1-0.19)"  dies a horrid death early
> > during the compile:
> >
> >   CC       /usr/src/linux-next/tools/objtool/str_error_r.o
> > ../lib/str_error_r.c: In function 'str_error_r':
> > ../lib/str_error_r.c:25:3: error: passing argument 1 to restrict-qualified parameter aliases with argument 5 [-Werror=restrict]
> >    snprintf(buf, buflen, "INTERNAL ERROR: strerror_r(%d, %p, %zd)=%d", errnum, buf, buflen, err);
> >    ^~~~~~~~
> > cc1: all warnings being treated as errors
> > mv: cannot stat '/usr/src/linux-next/tools/objtool/.str_error_r.o.tmp': No such file or directory
> > make[3]: *** [Build:22: /usr/src/linux-next/tools/objtool/str_error_r.o] Error 1
> > make[2]: *** [Makefile:46: /usr/src/linux-next/tools/objtool/objtool-in.o] Error 2
> > make[1]: *** [Makefile:63: objtool] Error 2
> > make: *** [Makefile:1681: tools/objtool] Error 2
> >
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=854e55ad289e

Confirming that fixes the problem...

--==_Exmh_1521657477_14535P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWrKmhY0DS38y7CIcAQK9iQf+ODwJwN6kmh0XamrdFe8zk5aFmaTXWgoE
Mxkp458rXW13/niwp0JxE0QJExzH8nw/z4os+VGTUzrxaThoGlk/gbB/ahyL2LDp
lDBCtGLycpBP4T98N/wBHdhKfOl+4iNNlEJ4MDrjdOZmqray4Wum6en93KPXRLij
OCTfbVAzdceFB2+8fUQUeEjyJrYUuq0Ls2x6RA17/H9IJ/OMOsJXVayGzv6SuZE5
/Gr9oFmDbkv4wRAZeLN42FFqLB9DMQ4BzF3MYlxX5Syz34iq51GoVFS0NP0ug6tb
nV1mMYFaS1zmHg8+CBTkaZ0yFzCIgW7uERINMrfcGHHg7N+IA/1Eiw==
=0OnH
-----END PGP SIGNATURE-----

--==_Exmh_1521657477_14535P--
