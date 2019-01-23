Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7ED7C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7688B2184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sflY5tc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfAWQGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:06:46 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34924 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfAWQGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 11:06:46 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so1402478plo.2;
        Wed, 23 Jan 2019 08:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2rmjyDyzr7HUrnxdAu2dlQTuj0fh8G9d7l0+rTPRw7s=;
        b=sflY5tc+q19XswaiZixKo+H/00VjAol4guW/zl3Ka2Q2zKiCK+vrgyzwAWbMh5SEt2
         39LAvfLqPES98PPJabXzCf+7pHReICXfVGWOt00TP8iBOelpM9X3x/k464BLMUNbG15v
         5Vh7qiv7byximWMgDvwDT3NkbQWOdXZ6paoyCm73xHPPpsBRLCo5qf53HKOtzBMu/xXn
         /8N6o1tJs/WcVPqNhadSi2RsZ2RrRhweiaHteZyJqq2uGzQ3i/YeHEpfbv/QgcpHTbla
         EudhWRweP8lrDMauw2cW0xQWSz/9bB5sja9hCoPqg8FabJO2LA7f4ZK0m9K4p+9C27nn
         EizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2rmjyDyzr7HUrnxdAu2dlQTuj0fh8G9d7l0+rTPRw7s=;
        b=I8LyZoDCY9CtF0fi1fLZhtLriIq9ee+BmAqgw7Rta89XmrhF8Ut9FpXu6cBBD+NQus
         XzBK8FsMPaXeJM0qGikbuVJGAMDr4LwrxmwdxCLa4swvso7sv5mvqbgA4raeHNjdbDqx
         sDTsvD6uibiFl9hQARJp00dOckbfbk9vYM6JYzjhvZfO7O3s3ai2lWF27U2CpZLVXs16
         4C0oMPDE4VYz2q0dVkvcHqoMb/tpXr8olaast+0IR3p04khux2PU7yGXJF7rQcY3G2fo
         k+Aq+of61s6hw+7NuDlaRLzw/ZVwL4z6b6zzYHlWCyd8M+5D3tWqkuBzhGi1cTKkutPt
         nh6w==
X-Gm-Message-State: AJcUukdAJe2JQCB1R6o1G0fNiEyxlFlJlm1Q+voF2ARdzP/eTVJYNWDQ
        SOh8bXvd5+Hj3ckP2vHOBOG4LffEM+zImCsuQbIagiej
X-Google-Smtp-Source: ALg8bN4+WaqKLW9rWAjG5hMwfKTMtWxtTVaS/UHsVnasAKobLC0Ss/eTl91am47jnGyv/yTz9JIMzpJ5k5NvWn4RNZY=
X-Received: by 2002:a17:902:e28e:: with SMTP id cf14mr2776868plb.311.1548259605671;
 Wed, 23 Jan 2019 08:06:45 -0800 (PST)
MIME-Version: 1.0
References: <1547475005-23435-1-git-send-email-guan.yung.tseng@ni.com> <CAHp75VcxtSi64qsK6tHx+vtEeRsX3ZVwfzRYOVuyS=qSTnK0qQ@mail.gmail.com>
In-Reply-To: <CAHp75VcxtSi64qsK6tHx+vtEeRsX3ZVwfzRYOVuyS=qSTnK0qQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 23 Jan 2019 18:06:33 +0200
Message-ID: <CAHp75Vd+p8d87v_YEkzMLh8sxmvPYk3XeFdkpsrY_jTsC2zHCQ@mail.gmail.com>
Subject: Re: [PATCH] 8250_pci.c: Update NI specific devices class to multi serial
To:     Guan Yung Tseng <guan.yung.tseng@ni.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000d11e1b0580224740"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000d11e1b0580224740
Content-Type: text/plain; charset="UTF-8"

On Wed, Jan 23, 2019 at 5:18 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Jan 14, 2019 at 4:13 PM Guan Yung Tseng <guan.yung.tseng@ni.com> wrote:
> >
> > Modified NI devices class to PCI_CLASS_COMMUNICATION_MULTISERIAL.
> > The reason of doing this is because all NI multi port serial cards
> > use PCI_CLASS_COMMUNICATION_OTHER class and thus fail the
> > serial_pci_is_class_communication test added in the commit 7d8905d06405
> > ("serial: 8250_pci: Enable device after we check black list").
>
> Guan, can you provide an output of the
>
> lspci -nk -xx -vv -s <BDF>
>
> of your device, where <BDF> is a PCI address in a form of bus:device.function?

While I'm still wondering of the above, can you also test the bellow
patch if it fixes your issue?




-- 
With Best Regards,
Andy Shevchenko

--000000000000d11e1b0580224740
Content-Type: text/x-patch; charset="US-ASCII"; name="8250-pci-1.diff"
Content-Disposition: attachment; filename="8250-pci-1.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jr9ds4ir0>
X-Attachment-Id: f_jr9ds4ir0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfcGNpLmMgYi9kcml2ZXJz
L3R0eS9zZXJpYWwvODI1MC84MjUwX3BjaS5jCmluZGV4IGY4MGEzMDBiNWQ2OC4uNDhiZDY5NGE1
ZmExIDEwMDY0NAotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX3BjaS5jCisrKyBi
L2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfcGNpLmMKQEAgLTM0MjAsNiArMzQyMCwxMSBA
QCBzdGF0aWMgaW50CiBzZXJpYWxfcGNpX2d1ZXNzX2JvYXJkKHN0cnVjdCBwY2lfZGV2ICpkZXYs
IHN0cnVjdCBwY2lzZXJpYWxfYm9hcmQgKmJvYXJkKQogewogCWludCBudW1faW9tZW0sIG51bV9w
b3J0LCBmaXJzdF9wb3J0ID0gLTEsIGk7CisJaW50IHJjOworCisJcmMgPSBzZXJpYWxfcGNpX2lz
X2NsYXNzX2NvbW11bmljYXRpb24oZGV2KTsKKwlpZiAocmMpCisJCXJldHVybiByYzsKIAogCS8q
CiAJICogU2hvdWxkIHdlIHRyeSB0byBtYWtlIGd1ZXNzZXMgZm9yIG11bHRpcG9ydCBzZXJpYWwg
ZGV2aWNlcyBsYXRlcj8KQEAgLTM2NDcsMTAgKzM2NTIsNiBAQCBwY2lzZXJpYWxfaW5pdF9vbmUo
c3RydWN0IHBjaV9kZXYgKmRldiwgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmVudCkKIAog
CWJvYXJkID0gJnBjaV9ib2FyZHNbZW50LT5kcml2ZXJfZGF0YV07CiAKLQlyYyA9IHNlcmlhbF9w
Y2lfaXNfY2xhc3NfY29tbXVuaWNhdGlvbihkZXYpOwotCWlmIChyYykKLQkJcmV0dXJuIHJjOwot
CiAJcmMgPSBzZXJpYWxfcGNpX2lzX2JsYWNrbGlzdGVkKGRldik7CiAJaWYgKHJjKQogCQlyZXR1
cm4gcmM7Cg==
--000000000000d11e1b0580224740--
