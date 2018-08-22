Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CABC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48E1208CD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A48E1208CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=burcheri.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbeHVLoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 07:44:10 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:55370 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbeHVLoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 07:44:10 -0400
Received: from localhost ([94.79.149.170]) by mrelayeu.kundenserver.de
 (mreue004 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0Ly8sz-1fvdWm1wnt-015YaH; Wed, 22 Aug 2018 10:20:17 +0200
Message-ID: <1534926011.18658.29.camel@burcheri.de>
Subject: MQ-BFQ crashing on battery mode
From:   Massimo Burcheri <massimo@burcheri.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAQMAAABtzGvEAAAAA3NCSVQICAjb4U/gAAAABlBMVEX///8AAABVwtN+AAAACXBIWXMAAA7EAAAOxAGVKw4bAAABGUlEQVQYlUWQsUoDQRCGv71LjB7KSSBwwZCTgFhY2EYIHmJnZRMLo5AXUMRCBMHcE6iPoGBlINpoZXGVeQTFKqSxMgYtTBFcZw7EKfZn2Z2Z7//hr2ysZ+5tqFLmWKVaKKs0vWd9TJx2AibmoQcupj6CCZirqTgzA5hmsdtQWe5/xAREX7uJ3MLP9x4lyieNO5mcOxyM8HH79y/4Cdn9R3JDsts/uGO82yOMJf/ah1Y8tfQEIQt7Z7rCawtNiUpHFgYUdgTxgI1NAW6SvxoqWabbw0Bd5jpQibTNBC1F4nIMk2TWhTqIs+fSVpzfCsVR9eaiJf5W6mtWXK7O+vKR4nWkSYSuFbP4No3Ht6dpSN9pSMYmaXI1/usXT0FM3SoTKAAAAAAASUVORK5CYII=
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-FkIqwNjyHCVyvhY4Q5sg"
Date:   Wed, 22 Aug 2018 10:20:11 +0200
Mime-Version: 1.0
X-Mailer: Evolution 3.24.6 
X-Provags-ID: V03:K1:Mnqr1GBAFbG4Bb6tq/HN6Dx4pX2HOzw9rS54ag7bzSUa8J2o3Ic
 gxHvTm3hHKaQCTxBT316DMeRC9Tdh9NsCKG/a3gsDicofw6hB6C4E/xM3aosbAyAWYS5LjN
 3ubQEDs7NzBSVtMLZihm6SvOEGSMSt4INuIrRaDr3z5HAoPzxiieTLNkHC855UjDi78QGRu
 um/h/4vk5MVNwpsjKi6gw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Lg9diYVSx8c=:IuMbSCOrdM3bF4YiFz3/7+
 DfyChlG0YHExouA5hn+LEcQIhVscTUi0sa4PYuyrUPAgp4rRh+M84XyAfeOJJKasmkDCBe7Dm
 CI3t46qVtRtHjrl6nf/tT2uJpYRDqzhqcSFJs4/hCakIEKyPlRL/Y6pHm7Mm+6+P9OSQJwOK9
 gAvZY2fQmPFrhbnNbkmDlwqaZdIFfxdklT212CZhk5EUDdj5v9N78LswEsKXlsfDJ5qYc6Kug
 F8VXlSBYRn+ElsoGr6JMJjl2OnElCWC3aoH1Dpp7b2P0/3J39gJABQp7yfvgIxywoYGSl4Jd9
 a3kRon1pVu3t4jYkDU1ezZnBZVN5PWQCA6EOTOCwGbDzdDSbNTeC8LO3MKm+Lnq8qbbqwGFuN
 D2jC81gLLivaQmVz40/DtV1xQqHtVes9DBDh4csCVydYncaawIyy7kExBljGFtoAEzqOqByea
 hqCo/ooR4OKzE4AnOF83s+nZeTdK0xY+rwAeZZjz2mmMesFSHwjbLF0C8zhf13y9pYCbR99F3
 tjeSZWSJjZBCvhFJwCCDIDARpf1Jsmz6BBMsaUrLjfZf3MVETiod4/6Eui72JXF9r/Bimcpbg
 om9d+AckpovuY7LKRb7XZethod7P6GCDY0kjA0DQiiyS8Ip+en7wtJFXinLVvPyW/JRXjuiy/
 nNbBbyUly+mGzjNSJK3kR7LGefjwQruvzQChcadV7KRl3hs0tCt7uPM/+1UZpSdqg1SMvX5rw
 YAQQDTHALJQTZjbP6fXnH00pihlWq2laQggsHZU581i+MWNNaupgwKBTG5hOkRWxWd3ffm3YD
 nuGf2Es
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FkIqwNjyHCVyvhY4Q5sg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,


I got a kernel trace when unplugging the power supply, switching to battery
mode. I get the same kernel trace when booting on battery.
Both making the system unusable or breaking the boot.

The kernel call trace with symbols:

? blk_mq_requeue_request+0x...
? __scsi_queue_insert+0x...
? ata_scsi_var_len_cdb_xlat+0x
? __blk_mq_complete_request+0x...
? ata_scsi_translate+0x...
? ata_scsi_queuecmd+0x...
? scsi_dispatch_cmd+0x...
? scsi_queue_rq+0x...
? blk_mq_dispatch_rq_list+0x...
? kyber_dispatch_cur_domain+0x...
? kyber_completed_request+0x...
? blk_mq_sched_dispatch_requests+0x...
? __ blk_mq_run_hw_queue+0x...
? __blk_mq_delay_run_hw_queue+0x...
? blk_mq_run_hw_queue+0x...
? blk_mq_run_hw_queues+0x...
? blk_mq_requeue_work+0x...
? process_one_work+0x...
? worker_thread+0x...
? process_one_work+0x...
? kthread+0x...
? kthread_flush_work_fn+0x...
? ret_from_fork+0x...
Code: ...
RIP: sbitmap_queue_clear+0x...

Screenshot: 	https://ibin.co/4D34Ej3DWsqI.jpg
Kernel config: 	https://bpaste.net/show/870004e55123

Kernel: 4.17.11-ck

Setup:

btrfs-on-bcache-on-luks
btrfs options (rw,noatime,nodiratime,compress-
force=3Dlzo,nossd,noacl,space_cache,autodefrag)

Using mq bfq scheduler for the hdd backing and kyber for the ssd caching de=
vice


Failed tests:
Tested many kernel down to 4.13.2 with Gentoo or Ck patchset. Sorry for not
including the vanilla sources in the test, I can provide if required.
Skipping services in the boot process didn't help, any next service leads t=
o the
same trace.
Switching off the laptop-mode-tools daemon didn't help.
Switching all devices to "none" scheduler did not help.


Workaround:
After some tests and due to the *mq* call stack I was able to workaround by
disabling CONFIG_SCSI_MQ_DEFAULT and CONFIG_DM_MQ_DEFAULT and switching all
devices to cfq scheduler.
However with the MQ enabled kernel, only bfq, kyber and none are possible, =
while
the non-mq kernel can only set cfq. I guess this is intentional as the curr=
ent
bfq implementation is a MQ only version and CFQ is a non-mq only version?

Best regards,
Massimo
--=-FkIqwNjyHCVyvhY4Q5sg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEjdL61EKP3VOAA+I8lQj3p5VSZjIFAlt9HLsACgkQlQj3p5VS
ZjL95hAAn3RpwMKbRwv3NjEfWwxpTaJXgtNIAW3rKxyEOO3jX0fhfA1rlEKtQ3r9
w6OCxaORedTpxB0QEIkd2Pe82fj5dteVSETQQsZ1w/PEYhY9nZkhebbhjB5X817x
tmwuYE3CDxn6Yti0phV7tIp9/TxmUaCybP1X8vR02t247x+lqnAPA+3eumig2y5o
YNOghADyJj7dmxnK8C0kcnPicDlxNacP/T7NtHA/3EHIc1/itGGPN6W+G6D2Jpn5
FOShUBCUX6rfc/z9HOWnhZXWGQfqgLp8fCPCainA7EH2DjcZn9xIRxRG/fdkja2w
Aoj4A4JNNLJ/9YSksTt26eaeGT8ybf9eujaDtBdrk1P6R3q6qZ2lgbUOE6V+7F5r
5KE8u1kvGBn8Q/wov6ZzvlR9vnV2GoUlJmSNiAgRt70WXmw3HXgTY5RTj1lnmbTj
1qWJCjdx3OumnfSgrs2s/amAHa3xMhcu7dLL5u7dEg9vzgHARrAve8aQLG/tpXGc
EAXDJIk0WhMeCXWXO3GtZCqTFelKS/BAUeCh7zQwx+U3laKqRr2oFKs6snAliY33
UlCV91Hd8iA6tZqkhWey0sAoXvSiOjRoEE5UywV9WWovTnjMsIsCwvgsfb7f0Vij
qvwAwhtL6G2AcbmioQvybC93r4ZbI0e2WmOvhwjzmMh4qZ8NmeI=
=h385
-----END PGP SIGNATURE-----

--=-FkIqwNjyHCVyvhY4Q5sg--

