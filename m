Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C41FC282C7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341F62087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="olgZZET/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbfAaG3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 01:29:55 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:39280 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbfAaG3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 01:29:53 -0500
Received: by mail-it1-f196.google.com with SMTP id a6so2276148itl.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 22:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=eFDbEtSS1uyI5MHSyojJDeLQoN/wOGEQjDFxj4o4/Pk=;
        b=olgZZET/aVtCaIbqiwtqkTGDKzC2/uk5WCZH+irZgQC6J/55gXxNhUFQGp9UE52YIs
         Z0ntwmgjtNf9wi+GXf4LJjc/04qFOGFOTvs7gpaNZGZmpfFVlLuTLoDI2TBYU4dSEs3B
         OCzFYEW+6wjWqpSgvm3LH0/yZn2WrbNjlWj7sngHVXzRTjr5vz1Y70lVV2k5mx1xyIYP
         24G1dcBB69qowjKgXqAtBbE7mXa0wPwLc08+c1ymY0WQuEfXQRaW0CRWT6j8E9ju8yyz
         tVVV9pa2oFbfF2g9gt7JJPJpO8Ui3Sjkhw5GMTD/XK5STHKsD7II/ly9MUr2M0Y/t52K
         bfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=eFDbEtSS1uyI5MHSyojJDeLQoN/wOGEQjDFxj4o4/Pk=;
        b=LA9TQZulidZp5mEL/4I1XA7AE22pm5aePugyIk9Xi+gcGrQcZIt+0PWLzttLkU1ZzC
         h075X/3cop6hUmyLrIp5dUXL/36yrc8zqo5S8+sdJo8nTrUjqH/1Bb5NQj3nODFKQIs5
         4Fr7RkbRzcrqLRtrW0g+Q41aGy1g6iPIecevY7KTAxIYYo1VXFG2dOcmhPi7YHMszfGG
         bQAVZV+eyFXcOLkh1SUI8FxGNFpTQE0Wo1w8rbOHl9QuXdwzeYn1AUEXeVU+8z5o6v8T
         m7YMj3koRsCcyG/xCg9Qrm7uwJCHTEfGLDLUhXNadfVDpHUTnjlnmFr+4us8Fd9f2W6b
         Rf/A==
X-Gm-Message-State: AHQUAuaW8UW2yYhcJlEPewfHhwadAt05NoDrhIEJ48+42DFi7B40ps5M
        K5jLKyphZpfWLv7iRN9BFSngRQ==
X-Google-Smtp-Source: AHgI3IY+yDYQ1I/rTECFYkkmrG2g6Ew+ltFLbZX8yJJ97KHLXo26khYEFhD3dtRP8pa872tUXnOkbw==
X-Received: by 2002:a05:660c:281:: with SMTP id s1mr3475579itl.36.1548916192822;
        Wed, 30 Jan 2019 22:29:52 -0800 (PST)
Received: from [192.168.43.100] ([172.58.139.162])
        by smtp.googlemail.com with ESMTPSA id 85sm1618146iou.8.2019.01.30.22.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 22:29:51 -0800 (PST)
To:     Linux-sh list <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
From:   Rob Landley <rob@landley.net>
Subject: Commit 594cc251fdd0 (user_access_begin does access_ok) made arch/sh
 stop booting on qemu.
Message-ID: <51e0329b-5d0b-1099-54f3-b51a34b6b216@landley.net>
Date:   Thu, 31 Jan 2019 00:29:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------8845AE82FA9AD89B674979E9"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8845AE82FA9AD89B674979E9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

That's what I bisected it to, anyway. Commit before that boots to a shell prompt
under qemu-system-sh4 (built from today's git), after produces no console output
(no boot messages, no nothin').

Rob

--------------8845AE82FA9AD89B674979E9
Content-Type: text/plain; charset=UTF-8;
 name="sh4.miniconf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="sh4.miniconf"

IyBtYWtlIEFSQ0g9c2ggYWxsbm9jb25maWcgS0NPTkZJR19BTExDT05GSUc9c2g0Lm1pbmlj
b25mCiMgbWFrZSBBUkNIPXNoIC1qICQobnByb2MpCiMgYm9vdCBhcmNoL3NoL2Jvb3Qveklt
YWdlCgoKQ09ORklHX0NQVV9TVUJUWVBFX1NINzc1MVI9eQpDT05GSUdfTU1VPXkKQ09ORklH
X01FTU9SWV9TVEFSVD0weDBjMDAwMDAwCkNPTkZJR19WU1lTQ0FMTD15CkNPTkZJR19TSF9G
UFU9eQpDT05GSUdfU0hfUlRTNzc1MVIyRD15CkNPTkZJR19SVFM3NzUxUjJEX1BMVVM9eQpD
T05GSUdfU0VSSUFMX1NIX1NDST15CkNPTkZJR19TRVJJQUxfU0hfU0NJX0NPTlNPTEU9eQoK
Q09ORklHX1BDST15CkNPTkZJR19ORVRfVkVORE9SX1JFQUxURUs9eQpDT05GSUdfODEzOUNQ
PXkKCkNPTkZJR19QQ0k9eQpDT05GSUdfQkxLX0RFVl9TRD15CkNPTkZJR19BVEE9eQpDT05G
SUdfQVRBX1NGRj15CkNPTkZJR19BVEFfQk1ETUE9eQpDT05GSUdfUEFUQV9QTEFURk9STT15
CgojQ09ORklHX1NQST15CiNDT05GSUdfU1BJX1NIX1NDST15CiNDT05GSUdfTUZEX1NNNTAx
PXkKCiNDT05GSUdfUlRDX0NMQVNTPXkKI0NPTkZJR19SVENfRFJWX1I5NzAxPXkKI0NPTkZJ
R19SVENfRFJWX1NIPXkKI0NPTkZJR19SVENfSENUT1NZUz15CgoKIyBDT05GSUdfRU1CRURE
RUQgaXMgbm90IHNldApDT05GSUdfRUFSTFlfUFJJTlRLPXkKQ09ORklHX0JJTkZNVF9FTEY9
eQpDT05GSUdfQklORk1UX1NDUklQVD15CkNPTkZJR19OT19IWj15CkNPTkZJR19ISUdIX1JF
U19USU1FUlM9eQoKQ09ORklHX0JMS19ERVY9eQpDT05GSUdfQkxLX0RFVl9JTklUUkQ9eQpD
T05GSUdfUkRfR1pJUD15CgpDT05GSUdfQkxLX0RFVl9MT09QPXkKQ09ORklHX0VYVDRfRlM9
eQpDT05GSUdfRVhUNF9VU0VfRk9SX0VYVDI9eQpDT05GSUdfVkZBVF9GUz15CkNPTkZJR19G
QVRfREVGQVVMVF9VVEY4PXkKQ09ORklHX01JU0NfRklMRVNZU1RFTVM9eQpDT05GSUdfU1FV
QVNIRlM9eQpDT05GSUdfU1FVQVNIRlNfWEFUVFI9eQpDT05GSUdfU1FVQVNIRlNfWkxJQj15
CkNPTkZJR19ERVZUTVBGUz15CkNPTkZJR19ERVZUTVBGU19NT1VOVD15CkNPTkZJR19UTVBG
Uz15CkNPTkZJR19UTVBGU19QT1NJWF9BQ0w9eQoKQ09ORklHX05FVD15CkNPTkZJR19QQUNL
RVQ9eQpDT05GSUdfVU5JWD15CkNPTkZJR19JTkVUPXkKQ09ORklHX0lQVjY9eQpDT05GSUdf
TkVUREVWSUNFUz15CiNDT05GSUdfTkVUX0NPUkU9eQojQ09ORklHX05FVENPTlNPTEU9eQpD
T05GSUdfRVRIRVJORVQ9eQoK
--------------8845AE82FA9AD89B674979E9
Content-Type: application/x-shellscript;
 name="qemu-sh4.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="qemu-sh4.sh"

cWVtdS1zeXN0ZW0tc2g0IC1NIHIyZCAtc2VyaWFsIG51bGwgLXNlcmlhbCBtb246c3RkaW8g
LW5vZ3JhcGhpYyAtbm8tcmVib290IC1tIDI1NiAtYXBwZW5kICJwYW5pYz0xIEhPU1Q9c2g0
IGNvbnNvbGU9dHR5U0MxIG5vaW90cmFwIiAta2VybmVsIHpJbWFnZSAtaW5pdHJkIHNoNC1s
aW51eC1tdXNsLXJvb3QuY3Bpby5neiAiJEAiCg==
--------------8845AE82FA9AD89B674979E9--
