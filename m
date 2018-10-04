Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3CFC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933E42084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcqajKK7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 933E42084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeJEEET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:04:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41418 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeJEEES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:04:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id x12-v6so11389661wru.8;
        Thu, 04 Oct 2018 14:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KINXlk27WRpSUheO0VnsIAEdikcBUGjWtxgADN3RBno=;
        b=XcqajKK7CXCZCvj8eOhx+lzX2CHglgXRXpZyb3CfmRFV+A5DefG64RzIvyWww0hn/N
         IhnvML1NTEKjV8q2hKY1arSH2wDITfMg/2ipcVVQVmsuRU7DbxgOTjDxZhQbIyTFodRF
         +AVhDTMTJwLy/5LifLrZHFDPUqhj51S9ty0pmmtupcQTpEZzB323QbI9hirLaUF8xgPN
         RpqKvTmcKqdnixVvt3Ds2rlLW2DGrFX8HRAA2kv+YL4MCrLVpfL2Mnu6wQ2zp+6FZE4g
         e1xnePP22Wf92tzG+kY1vKh7W+mXzTt1o92IUgmJYsgiF/K7EJ3IRNhw6DDcLqpjZpFW
         i/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KINXlk27WRpSUheO0VnsIAEdikcBUGjWtxgADN3RBno=;
        b=FTFRDnNMzdS/t7MtCTPDANWxxWDYZ6ewivRzWVf/djdv77H95ICuQfBPVR/9VPl1C3
         eZMG4ae/fuvXNOEsQg+dzpHXcuhNrqsvGFDJj785I8KaWqKA2POs1yk55c3YDCFjH5kD
         JCxqxG5GPsI0Ba5Iopa1N4s9C++Ff3060E0o5CSGeSQx6PsF8NnMAnii7EK7Z4q/kIs7
         veFKiwfLdxJHKHelB4AFaq/DHClUAr2KlW3OZCO0i53lUiRRXzD292XEPQjXYSxUMeQR
         YWay4LZEqH13rL4HAs/LI3cYAXGsSqzSsScgC9rpTJ9NVsS8BV2bOJxs2t9wOmGLtacU
         dyAg==
X-Gm-Message-State: ABuFfoj1He5n7JIRD6OjTE6yO4XTscis0Cy9/xBh2mVf7/litvQc+/02
        y3YAwda3dFIQ04oqJT2RmWXxGzsu/y6ZiZu+tLU=
X-Google-Smtp-Source: ACcGV63mIorQiv+kiFrXYSuXsjjzT6nbkN1oXqOmlzw5riUcKmZjXC9aPiavNxY0FZVGjHxBMTVrZUBW8+UnpwvRMa8=
X-Received: by 2002:adf:b3d7:: with SMTP id x23-v6mr6173507wrd.253.1538687349817;
 Thu, 04 Oct 2018 14:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <CACE8ZKbUhFyWg5oK1B8+aWAa0tdqKf5Kokj80+8x1X2EUaA_DQ@mail.gmail.com>
In-Reply-To: <CACE8ZKbUhFyWg5oK1B8+aWAa0tdqKf5Kokj80+8x1X2EUaA_DQ@mail.gmail.com>
From:   =?UTF-8?Q?Ren=C3=A9_Kjellerup?= <rk.katana.steel@gmail.com>
Date:   Thu, 4 Oct 2018 14:08:55 -0700
Message-ID: <CACE8ZKZEpQjOW6CSvUuM9xhjtkSCF0bYxcfQ3htSabC=rVJcTA@mail.gmail.com>
Subject: Adding a Basic DT for the Linksys ea6500 v2 wireless home router
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     "Cc: Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="000000000000e8d96d05776d906a"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e8d96d05776d906a
Content-Type: text/plain; charset="UTF-8"

Hi Hauke,

thank you for suggesting adding the dts patch to mainline kernel,
so here it is.
I feel Rafal technically still have the copyrights, this is pretty
much just a few string updates for the ea6500v2. However with this
dts in latest OpenWrt 18.06 loads and installs on my device.

I will be available to do more testing should it be required.

Regrads
Rene Kjellerup
--
-- as life grows older, I gain experience.
-- http://www.alchemiestick.net/

--000000000000e8d96d05776d906a
Content-Type: application/x-patch; 
	name="0001-ARM-dts-BCM5301X-Add-basic-DT-for-Linksys-EA6500-V2.patch"
Content-Disposition: attachment; 
	filename="0001-ARM-dts-BCM5301X-Add-basic-DT-for-Linksys-EA6500-V2.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jmqu74zq0>
X-Attachment-Id: f_jmqu74zq0

RnJvbSBiZGM0NDI5MzUzZWUwNGY0OTc0OTUwMTZjOWVlYmFjMTg4NjAzOTBjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSZW5lIEtqZWxsZXJ1cCA8cmsua2F0YW5hLnN0ZWVsQGdtYWls
LmNvbT4KRGF0ZTogTW9uLCAxIE9jdCAyMDE4IDE0OjExOjU2IC0wNzAwClN1YmplY3Q6IFtQQVRD
SF0gQVJNOiBkdHM6IEJDTTUzMDFYOiBBZGQgYmFzaWMgRFQgZm9yIExpbmtzeXMgRUE2NTAwIFYy
CgpJdCdzIHdpcmVsZXNzIGhvbWUgcm91dGVyIGJhc2VkIG9uIEJDTTQ3MDhBMCB3aXRoIEJDTTQz
NjAgKyBCQ000MzMxCndpcmVsZXNzIGNoaXBzZXRzLiBUaGUgQkNNNDMzMSA1R0h6IGNoaXAgY3Vy
cmVudGx5IGlzbid0IHN1cHBvcnRlZApvbmx5IGR1ZSB0byBtaXNzaW5nIGNvbXBhdGlibGUgZmly
bXdhcmUuCgpTaWduZWQtb2ZmLWJ5OiBSZW5lIEtqZWxsZXJ1cCA8cmsua2F0YW5hLnN0ZWVsQGdt
YWlsLmNvbT4KLS0tCiBhcmNoL2FybS9ib290L2R0cy9NYWtlZmlsZSAgICAgICAgICAgICAgICAg
ICAgICB8ICAxICsKIGFyY2gvYXJtL2Jvb3QvZHRzL2JjbTQ3MDgtbGlua3N5cy1lYTY1MDAtdjIu
ZHRzIHwgNDUgKysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCA0NiBp
bnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vYm9vdC9kdHMvYmNtNDcw
OC1saW5rc3lzLWVhNjUwMC12Mi5kdHMKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9N
YWtlZmlsZSBiL2FyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlCmluZGV4IGI1YmQzZGU4N2MzMy4u
YWRmOGYyOGY1ZTQ0IDEwMDY0NAotLS0gYS9hcmNoL2FybS9ib290L2R0cy9NYWtlZmlsZQorKysg
Yi9hcmNoL2FybS9ib290L2R0cy9NYWtlZmlsZQpAQCAtODgsNiArODgsNyBAQCBkdGItJChDT05G
SUdfQVJDSF9CQ01fNTMwMVgpICs9IFwKIAliY200NzA4LWFzdXMtcnQtYWM2OHUuZHRiIFwKIAli
Y200NzA4LWJ1ZmZhbG8td3pyLTE3NTBkaHAuZHRiIFwKIAliY200NzA4LWxpbmtzeXMtZWE2MzAw
LXYxLmR0YiBcCisJYmNtNDcwOC1saW5rc3lzLWVhNjUwMC12Mi5kdGIgXAogCWJjbTQ3MDgtbHV4
dWwteGFwLTE1MTAuZHRiIFwKIAliY200NzA4LWx1eHVsLXh3Yy0xMDAwLmR0YiBcCiAJYmNtNDcw
OC1uZXRnZWFyLXI2MjUwLmR0YiBcCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9iY200
NzA4LWxpbmtzeXMtZWE2NTAwLXYyLmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2JjbTQ3MDgtbGlu
a3N5cy1lYTY1MDAtdjIuZHRzCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAw
MC4uYmFiY2ZlYzUwZGRlCi0tLSAvZGV2L251bGwKKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYmNt
NDcwOC1saW5rc3lzLWVhNjUwMC12Mi5kdHMKQEAgLTAsMCArMSw0NSBAQAorLy8gU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIgT1IgTUlUCisvKgorICogQ29weXJpZ2h0
IChDKSAyMDE3IFJhZmHFgiBNacWCZWNraSA8cmFmYWxAbWlsZWNraS5wbD4KKyAqIENvcHlyaWdo
dCAoQykgMjAxOCBSZW5lIEtqZWxsZXJ1cCA8cmsua2F0YW5hLnN0ZWVsQGdtYWlsLmNvbT4KKyAq
LworCisvZHRzLXYxLzsKKworI2luY2x1ZGUgImJjbTQ3MDguZHRzaSIKKyNpbmNsdWRlICJiY201
MzAxeC1uYW5kLWNzMC1iY2g4LmR0c2kiCisKKy8geworCWNvbXBhdGlibGUgPSAibGlua3N5cyxl
YTY1MDAtdjIiLCAiYnJjbSxiY200NzA4IjsKKwltb2RlbCA9ICJMaW5rc3lzIEVBNjUwMCBWMiI7
CisKKwljaG9zZW4geworCQlib290YXJncyA9ICJjb25zb2xlPXR0eVMwLDExNTIwMCI7CisJfTsK
KworCW1lbW9yeSB7CisJCXJlZyA9IDwweDAwMDAwMDAwIDB4MDgwMDAwMDA+OworCX07CisKKwln
cGlvLWtleXMgeworCQljb21wYXRpYmxlID0gImdwaW8ta2V5cyI7CisJCSNhZGRyZXNzLWNlbGxz
ID0gPDE+OworCQkjc2l6ZS1jZWxscyA9IDwwPjsKKworCQl3cHMgeworCQkJbGFiZWwgPSAiV1BT
IjsKKwkJCWxpbnV4LGNvZGUgPSA8S0VZX1dQU19CVVRUT04+OworCQkJZ3Bpb3MgPSA8JmNoaXBj
b21tb24gNyBHUElPX0FDVElWRV9MT1c+OworCQl9OworCisJCXJlc3RhcnQgeworCQkJbGFiZWwg
PSAiUmVzZXQiOworCQkJbGludXgsY29kZSA9IDxLRVlfUkVTVEFSVD47CisJCQlncGlvcyA9IDwm
Y2hpcGNvbW1vbiAxMSBHUElPX0FDVElWRV9MT1c+OworCQl9OworCX07Cit9OworCismdXNiM19w
aHkgeworCXN0YXR1cyA9ICJva2F5IjsKK307Ci0tIAoyLjE2LjQKCg==
--000000000000e8d96d05776d906a--
