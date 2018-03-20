Return-Path: <valdis.kletnieks@vt.edu>
X-Google-Smtp-Source: AG47ELt74JkZ62Gh0ZxGJQtlLZi/OU045VUP0vFojrzqplm9VYO6gPuFQDO1m/HEzuFpROclkgYs
ARC-Seal: i=1; a=rsa-sha256; t=1521564220; cv=none;
        d=google.com; s=arc-20160816;
        b=OTqtdaW8hkfugI5kTh/ILTnitYGrNEpHaBp75YRoalIG//zOLZdiV/laB8u2yGzNPO
         oMj6ijztQeq5atYQCSG2/ATufimDPFC32gg4sAtq6ne7/9EAc55HfjL1Sg6tKxmeIJtw
         cNtdeQkZVWT0VtZYyh92ohLO0uhKGIXeoc9TMo8/CliYIUJwVXISUdsrlY0GJPXbAL3o
         00F4LVwFXKdgUTx8DEr9jx5hyQjGjXiF4OGP+g5wrXFYhjaYLl+kVS21VZTA8QHIoxjP
         FoWoFv7dbbhwSPr0zY15x/WQsPvbpGbCpmEf7RWobWm2Ac4a5zQ39iTMpI4ipPpUDah5
         /y7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:content-transfer-encoding:mime-version:subject:cc
         :to:from:arc-authentication-results;
        bh=FqrWNHbH2fcicC6c5h4K6MKTB/wDAT43cC9z6RSR/4Q=;
        b=U8mpzZ60ANCCY1mB4Z+CVjPzdWzeGmyB7DbijaQ3kY+iHIgV/vOtXlzlgT4JNXugKf
         jXZmZt7TcWUCqOsHFTtV6p9I43pTqDdtMRN03nvSI1wQTTrKtFhxioByI9ObaiPdnVd2
         +irCTD0PguLslNx+K4JKz7HWB08MjdjsabXzOvcuW951401geuUO7UROGQGm0LuS7Bre
         8LpE2giOSW3UZZ+hKo08OFwQ0C1vLcNDutHO8mUKcVQ8JBGe6V68j8tlraedPY8vhH5n
         POyTmoBi0e0deSPi1RqAzWjdS3x8MpkpjzX73ttofHX98YTUG6Rg73PtpMZL3F4F60Fe
         QUFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of valdis.kletnieks@vt.edu designates 2607:b400:92:8400:0:33:fb76:806e as permitted sender) smtp.mailfrom=valdis.kletnieks@vt.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=vt.edu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of valdis.kletnieks@vt.edu designates 2607:b400:92:8400:0:33:fb76:806e as permitted sender) smtp.mailfrom=valdis.kletnieks@vt.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
From: valdis.kletnieks@vt.edu
To: Arnaldo Carvalho de Melo <acme@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: linux-next 20180320 compile failure - tools/lib/str_error_r.c
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1521564212_3137P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Mar 2018 12:43:32 -0400
Message-ID: <40533.1521564212@turing-police.cc.vt.edu>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595475724335352111?=
X-GMAIL-MSGID: =?utf-8?q?1595475724335352111?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--==_Exmh_1521564212_3137P
Content-Type: text/plain; charset=us-ascii

Not sure who to blame here, or what changed in gcc between 0.16 and 0.19,
or what the proper fix is here....

next-20180307 with "gcc version 8.0.1 20180222 (Red Hat 8.0.1-0.16)" built and runs fine.

next-20180320 with "gcc (GCC) 8.0.1 20180317 (Red Hat 8.0.1-0.19)"  dies a horrid death early
during the compile:

  CC       /usr/src/linux-next/tools/objtool/str_error_r.o
../lib/str_error_r.c: In function 'str_error_r':
../lib/str_error_r.c:25:3: error: passing argument 1 to restrict-qualified parameter aliases with argument 5 [-Werror=restrict]
   snprintf(buf, buflen, "INTERNAL ERROR: strerror_r(%d, %p, %zd)=%d", errnum, buf, buflen, err);
   ^~~~~~~~
cc1: all warnings being treated as errors
mv: cannot stat '/usr/src/linux-next/tools/objtool/.str_error_r.o.tmp': No such file or directory
make[3]: *** [Build:22: /usr/src/linux-next/tools/objtool/str_error_r.o] Error 1
make[2]: *** [Makefile:46: /usr/src/linux-next/tools/objtool/objtool-in.o] Error 2
make[1]: *** [Makefile:63: objtool] Error 2
make: *** [Makefile:1681: tools/objtool] Error 2



--==_Exmh_1521564212_3137P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWrE6NI0DS38y7CIcAQK96Qf/Y5tDMvLqleA4858uw8dFjS1kISCXD/6C
bDCLoiNCvNwPsMYg8puaphVcWLFccZUXpVlvqmPkpK4mTvaOQXHD/LUyXD00SLhY
7eCOV0bK+cPnupAKIzHLPYaXWgPDOUDJI01a/3JFLqj3WDPRnrsHm4h1SSSXP6kN
e2WqpItFFziWCofuHYa2B5EEfNbVKiBy5esRpNuUwZJcW8r8pWXZJj5llP1N+nh0
zyyWgzlaB1hzqmq/96E6oMuGJ3Ktukp9S5Rea1QaP29AvuGVBNsre9k3oQVMBeU8
96HZd0HNyRKH3ckjU3EWj68scjKB5K+PyyPQPQfurEqUlaWyMQFLeQ==
=i9fJ
-----END PGP SIGNATURE-----

--==_Exmh_1521564212_3137P--
