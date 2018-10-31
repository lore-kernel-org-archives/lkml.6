Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639D4ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DEC2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXOx4wSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28DEC2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbeKADls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:41:48 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:38811 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729828AbeKADls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:41:48 -0400
Received: by mail-ot1-f49.google.com with SMTP id f24so9777522otl.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ehWshIqLveylbpWzvfwGxkJaoE60z0Yj/+ep2HzxEvM=;
        b=EXOx4wSKWeXjGRrBd9bceGo2T/Qx5vJAM1i3XaXSui+1ZkBfWPEJBLFHxxakBU/y1f
         8r38553YF61GvGGWWrjIQ3P4q5y7k/KxfCpdZRD3lA69kU6bukXhha68nwEb8B9GZkIO
         QLSWjfTuDhSsprHmHXehwffbi8gaGwJwsn38jKBkmj5UwQTdagfbNfZtXglOugiEdKB9
         erSjlxTnZEUVk+JKgdLAOOGqaFflaXkaItfxs70LiEUDGENAvVfx+37DwL7iY2jH4WC0
         4aIn3sYuo3JXgGPjLnCxfIyac+E99BW22snNuavHeS1sTYeZiGB0NKPlko4SmPL/koxV
         +5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ehWshIqLveylbpWzvfwGxkJaoE60z0Yj/+ep2HzxEvM=;
        b=cBi+1P2H4eJzxXfggL0Vq2VVLExuNeKhMiJFSAfS7zwIqiASUgwKl3ZebpFGnTcEAt
         auV+OEse+SvAQ9L4F41a15fqbOASFR5xXIZOWpjHU0yMIet0itIpLkt1Ide6IzEP3glh
         N0d+SMDWlhHcKenNr2Rkfyhit/BG9bGZfSmZzmhE653Y1D5Eq6NJ0Hbo5/femNS3StHt
         YijwrPcZGtgBWfYYjsRUcRjXJKAfzlkmYdioBwcoUHyR3VyhyX7O4zjOCYhnXE95/pWB
         kG2mck5gwgoBp4CdClVGrE8Q40a+QGR3z7qOW3Zi0iZZvzGnZqiX9JOBF9s/H4pTLhRK
         WcgQ==
X-Gm-Message-State: AGRZ1gLec56vwxWaaadnTx2qTmqFs+dq62uh/Wvi1d0ITDpkWr4Q2gr6
        N2jWBpxCsnbub+nBrDUljzhaFE6dE96rDFf+Ysj07ei9
X-Google-Smtp-Source: AJdET5c01tMgihyKLp5XvW3m+B6NaGlmC2Sihd/ntBkTCDRxKc+oSABfBAvXzWKSnErp7tF/s87/r3NfAboFsQ48L1k=
X-Received: by 2002:a9d:2fac:: with SMTP id r41mr2482079otb.169.1541011352377;
 Wed, 31 Oct 2018 11:42:32 -0700 (PDT)
MIME-Version: 1.0
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Wed, 31 Oct 2018 11:41:55 -0700
Message-ID: <CAMe9rOrodUScDD1A04m3rxOwReNGkKwa2yeXMYqSqa118r8dwg@mail.gmail.com>
Subject: [PATCH] Fix compat_sys_preadv64v2/compat_sys_pwritev64v2
To:     LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: multipart/mixed; boundary="00000000000041053705798aaaf7"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000041053705798aaaf7
Content-Type: text/plain; charset="UTF-8"

Update compat_sys_preadv64v2 and compat_sys_pwritev64v2 to handle the
offset argument == -1, which should use and update the the current file
offset.


-- 
H.J.

--00000000000041053705798aaaf7
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Fix-compat_sys_preadv64v2-compat_sys_pwritev64v2.patch"
Content-Disposition: attachment; 
	filename="0001-Fix-compat_sys_preadv64v2-compat_sys_pwritev64v2.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jnxibw730>
X-Attachment-Id: f_jnxibw730

RnJvbSA5MzRhNjhiZThhMDkyZGJhOTU1OGJkZjgwMjUyMzk5MzRlZmI1ZDdlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiSC5KLiBMdSIgPGhqbC50b29sc0BnbWFpbC5jb20+CkRhdGU6
IFdlZCwgMyBPY3QgMjAxOCAwODowNzoxOCAtMDcwMApTdWJqZWN0OiBbUEFUQ0hdIEZpeCBjb21w
YXRfc3lzX3ByZWFkdjY0djIvY29tcGF0X3N5c19wd3JpdGV2NjR2MgoKVXBkYXRlIGNvbXBhdF9z
eXNfcHJlYWR2NjR2MiBhbmQgY29tcGF0X3N5c19wd3JpdGV2NjR2MiB0byBoYW5kbGUgdGhlCm9m
ZnNldCBhcmd1bWVudCA9PSAtMSwgd2hpY2ggc2hvdWxkIHVzZSBhbmQgdXBkYXRlIHRoZSB0aGUg
Y3VycmVudCBmaWxlCm9mZnNldC4KClNpZ25lZC1vZmYtYnk6IEguSi4gTHUgPGhqbC50b29sc0Bn
bWFpbC5jb20+Ci0tLQogZnMvcmVhZF93cml0ZS5jIHwgNiArKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9mcy9yZWFkX3dyaXRlLmMgYi9mcy9yZWFk
X3dyaXRlLmMKaW5kZXggMzliNGEyMWRkOTMzLi5hNjExMTFiZGQ4YzkgMTAwNjQ0Ci0tLSBhL2Zz
L3JlYWRfd3JpdGUuYworKysgYi9mcy9yZWFkX3dyaXRlLmMKQEAgLTEyNDEsNiArMTI0MSw5IEBA
IENPTVBBVF9TWVNDQUxMX0RFRklORTUocHJlYWR2NjR2MiwgdW5zaWduZWQgbG9uZywgZmQsCiAJ
CWNvbnN0IHN0cnVjdCBjb21wYXRfaW92ZWMgX191c2VyICosdmVjLAogCQl1bnNpZ25lZCBsb25n
LCB2bGVuLCBsb2ZmX3QsIHBvcywgcndmX3QsIGZsYWdzKQogeworCWlmIChwb3MgPT0gLTEpCisJ
CXJldHVybiBkb19jb21wYXRfcmVhZHYoZmQsIHZlYywgdmxlbiwgZmxhZ3MpOworCiAJcmV0dXJu
IGRvX2NvbXBhdF9wcmVhZHY2NChmZCwgdmVjLCB2bGVuLCBwb3MsIGZsYWdzKTsKIH0KICNlbmRp
ZgpAQCAtMTM0Nyw2ICsxMzUwLDkgQEAgQ09NUEFUX1NZU0NBTExfREVGSU5FNShwd3JpdGV2NjR2
MiwgdW5zaWduZWQgbG9uZywgZmQsCiAJCWNvbnN0IHN0cnVjdCBjb21wYXRfaW92ZWMgX191c2Vy
ICosdmVjLAogCQl1bnNpZ25lZCBsb25nLCB2bGVuLCBsb2ZmX3QsIHBvcywgcndmX3QsIGZsYWdz
KQogeworCWlmIChwb3MgPT0gLTEpCisJCXJldHVybiBkb19jb21wYXRfd3JpdGV2KGZkLCB2ZWMs
IHZsZW4sIGZsYWdzKTsKKwogCXJldHVybiBkb19jb21wYXRfcHdyaXRldjY0KGZkLCB2ZWMsIHZs
ZW4sIHBvcywgZmxhZ3MpOwogfQogI2VuZGlmCi0tIAoyLjE3LjIKCg==
--00000000000041053705798aaaf7--
