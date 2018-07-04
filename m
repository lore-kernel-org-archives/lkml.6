Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E786C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDB220840
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="x4NEpBZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDB220840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbeGDOho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:37:44 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41588 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752383AbeGDOhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:37:41 -0400
Received: by mail-oi0-f66.google.com with SMTP id k12-v6so11112936oiw.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 07:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9BVoaAKoKE/YD4+XwjmUH1iRxUQeOIYvpTMinzlfwBc=;
        b=x4NEpBZC0wzXfS5nT8obcVL/8PbjEJuh2749RTP49ph5mA1+cuK3RiDsSTdXRw0bMw
         Z8cs/I7qvKy/zukuuwB5kIZYlcxGqgiY6q+1Qdy8xLN5T6NkhwLBx4zuUs9qnTz8BjG/
         4P6MfWLydy2TH7yjYEjIMz4tivj2N63WrDwmeLqH/S246IR87b/HSWArB2E6BvwvzvdZ
         JVArQ35kAkRedasFEFvGGyx+dhY0EauoztGLl+0Zd6W17krrHmJ64wr8IpjPVmO10+fp
         hQEzR2y6KGu+MhjI/oYIPPkjTSY2tjX2SrGRRzSYg7np7Y4QZbDcYKG9y872Vx6n8hD8
         +2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9BVoaAKoKE/YD4+XwjmUH1iRxUQeOIYvpTMinzlfwBc=;
        b=CRTcGXUVvty9liOVwMyePRmrtRNKDW0ZxDShvM33HrTWcjUPbSdRtG1WTixX6QW/hj
         vR5FepPS6hSZznmXyCZ1hNWPgqxVJNYV/jn9Zy4p/XYhqfrdc2IFvJ0GERyw7D0nH6xp
         NwVv01BasTKGtEebzQsP0/6IjXhSekTRNaRLv1lRG/2348Dw7rDHzD7aQ0/OQeB/6DEo
         H39UtVVwCK8SLIbSv6rbFkruGB0MP2H/EqeWm69iB3bBbt1DxqKGemf4jc0lktQ2rH/g
         5gK7OLHIcXvmelRTOtYzUwJTr8HmjHjklhTImE36lnz6YbZCZEOY9sh9O78WUF/umtgK
         iDTQ==
X-Gm-Message-State: APt69E3LtIG7R1ce382ySP6u3fSI/BjaklQPplAx8kR+vdXB4/NkJFqt
        o9uSUI7kl0V234q8oJMQ8HGn9pVL2aOguE6POHC05A==
X-Google-Smtp-Source: AAOMgpegGfnq5TiDuWkqotRTRBv6gNGnqif1FZaloEeM5uUZQS8HV40Hy6MJJ/HMqoslE9LV+gmRhHxj+yWEFbzGRVk=
X-Received: by 2002:aca:3d43:: with SMTP id k64-v6mr2389219oia.166.1530715061123;
 Wed, 04 Jul 2018 07:37:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3495:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 07:37:40 -0700 (PDT)
In-Reply-To: <1646567c191.ed8ea5b817045.8715756414911693238@zoho.com>
References: <20180704064058.1344-1-yehs2007@zoho.com> <20180704064058.1344-3-yehs2007@zoho.com>
 <20180704113012.trnfzeefao25clri@quack2.suse.cz> <1646567c191.ed8ea5b817045.8715756414911693238@zoho.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 4 Jul 2018 07:37:40 -0700
Message-ID: <CAPcyv4hPEch02C7UfCGgpXmsCVyT2zwV=4Tr8jv8W1i6_poAJQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] fs/dax: Assigning NULL to gfn of dax_direct_access if useless
To:     yehs2007@zoho.com
Cc:     Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Jan Kara <jack@suse.com>, NingTing Cheng <chengnt@lenovo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Huaisheng Ye <yehs1@lenovo.com>, colyli <colyli@suse.de>
Content-Type: multipart/mixed; boundary="00000000000078b3a005702d5f0a"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000078b3a005702d5f0a
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 4, 2018 at 6:07 AM, Huaisheng Ye <yehs2007@zoho.com> wrote:
>  ---- On Wed, 04 Jul 2018 19:30:12 +0800 Jan Kara <jack@suse.cz> wrote ----
>  > On Wed 04-07-18 14:40:58, Huaisheng Ye wrote:
>  > > From: Huaisheng Ye <yehs1@lenovo.com>
>  > >
>  > > Some functions within fs/dax don't need to get gfn from direct_access.
>  > > Assigning NULL to gfn of dax_direct_access is more intuitive and simple
>  > > than offering a useless local variable.
>  > >
>  > > Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
>  >
>  > I like this. You can add:
>  >
>  > Reviewed-by: Jan Kara <jack@suse.cz>
>  >
>  > for the series.
>  >
>  >                                 Honza
>  >
> I am so happy you like them, thank you very much.

Yes, I like this too. In fact I have a similar patch in my tree
already that I have been preparing to send out. I am using it to delay
when we need to have the 'struct page' memmap for dax initialized.
Attached is the full patch, but the series is still a work in
progress.

--00000000000078b3a005702d5f0a
Content-Type: text/x-patch; charset="US-ASCII"; name="0001-dax-Elide-pfn-lookups.patch"
Content-Disposition: attachment; filename="0001-dax-Elide-pfn-lookups.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jj78813i0

RnJvbSA2MmUxMmFiZWJhY2JhZmRiNTIxOGE5MjUwMTg4NWZlMGU4MGVhOTIyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNv
bT4KRGF0ZTogV2VkLCAyNyBKdW4gMjAxOCAyMjoyMTozMCAtMDcwMApTdWJqZWN0OiBbUEFUQ0hd
IGRheDogRWxpZGUgcGZuIGxvb2t1cHMKCldoZW4gbm90IHJlcXVpcmVkLCBhbGxvdyBkcml2ZXJz
IHRvIHNraXAgcmV0dXJuaW5nIGEgcGZuIGlmIG9uZSB3YXMgbm90CnJlcXVlc3RlZC4gSW4gc3Vw
cG9ydCBvZiBhc3luY2hyb25vdXMgaW5pdGlhbGl6YXRpb24gb2YgJ3N0cnVjdCBwYWdlJwp0aGVy
ZSBuZWVkcyB0byBiZSBhIHN5bmMgcG9pbnQgYXQgd2hpY2ggdGhlIG1lbW1hcCBpcyBtYWRlIHZh
bGlkLiBUaGUKbGF0ZXN0IHBvaW50IHdoZXJlIHRoZSBrZXJuZWwgY2FuIHJlYXNvbmFibHkgc3lu
YyBpcyB3aGVuIGEgcGZuIGlzIGJlaW5nCnVzZWQgdG8gcG9wdWxhdGUgdXNlcnNwYWNlIHBhZ2Ug
dGFibGVzLiBPdGhlcndpc2UsIGlmIG9ubHkgdGhlIGtlcm5lbAphZGRyZXNzIGlzIG5lZWRlZCBm
cm9tIGRheF9kaXJlY3RfYWNjZXNzKCksIHR5cGljYWxseSBpbi1rZXJuZWwgdXNlcnMsCnRoZW4g
dGhlICdwZm5fdCAqJyBhcmd1bWVudCB0byBkYXhfZGlyZWN0X2FjY2VzcygpIGNhbiBiZSBOVUxM
LgoKU2lnbmVkLW9mZi1ieTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+
Ci0tLQogZHJpdmVycy9kYXgvc3VwZXIuYyAgICAgICAgICAgICB8IDE3ICsrKysrKysrKysrLS0t
LS0tCiBkcml2ZXJzL252ZGltbS9wbWVtLmMgICAgICAgICAgIHwgIDMgKystCiBkcml2ZXJzL3Mz
OTAvYmxvY2svZGNzc2Jsay5jICAgIHwgIDUgKysrLS0KIGZzL2RheC5jICAgICAgICAgICAgICAg
ICAgICAgICAgfCAxMCArKystLS0tLS0tCiB0b29scy90ZXN0aW5nL252ZGltbS9wbWVtLWRheC5j
IHwgIDYgKysrKy0tCiA1IGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDE4IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZGF4L3N1cGVyLmMgYi9kcml2ZXJzL2RheC9z
dXBlci5jCmluZGV4IDNiMWZlNGI2YjAwZS4uODIyNTY1MDZlNDBiIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2RheC9zdXBlci5jCisrKyBiL2RyaXZlcnMvZGF4L3N1cGVyLmMKQEAgLTcyLDcgKzcyLDcg
QEAgc3RydWN0IGRheF9kZXZpY2UgKmZzX2RheF9nZXRfYnlfYmRldihzdHJ1Y3QgYmxvY2tfZGV2
aWNlICpiZGV2KQogRVhQT1JUX1NZTUJPTF9HUEwoZnNfZGF4X2dldF9ieV9iZGV2KTsKICNlbmRp
ZgogCi1zdGF0aWMgYm9vbCB2YWxpZGF0ZV9kYXhfcGZuKHBmbl90IHBmbikKK3N0YXRpYyBib29s
IHZhbGlkYXRlX2RheF9wZm4ocGZuX3QgKnBmbikKIHsKIAlib29sIGRheF9lbmFibGVkID0gZmFs
c2U7CiAKQEAgLTg0LDcgKzg0LDcgQEAgc3RhdGljIGJvb2wgdmFsaWRhdGVfZGF4X3BmbihwZm5f
dCBwZm4pCiAJaWYgKCFJU19FTkFCTEVEKENPTkZJR19EQVhfRFJJVkVSX0RFQlVHKSkKIAkJcmV0
dXJuIHRydWU7CiAKLQlpZiAoSVNfRU5BQkxFRChDT05GSUdfRlNfREFYX0xJTUlURUQpICYmIHBm
bl90X3NwZWNpYWwocGZuKSkgeworCWlmIChJU19FTkFCTEVEKENPTkZJR19GU19EQVhfTElNSVRF
RCkgJiYgcGZuX3Rfc3BlY2lhbCgqcGZuKSkgewogCQkvKgogCQkgKiBBbiBhcmNoIHRoYXQgaGFz
IGVuYWJsZWQgdGhlIHBtZW0gYXBpIHNob3VsZCBhbHNvCiAJCSAqIGhhdmUgaXRzIGRyaXZlcnMg
c3VwcG9ydCBwZm5fdF9kZXZtYXAoKQpAQCAtOTUsMTAgKzk1LDEwIEBAIHN0YXRpYyBib29sIHZh
bGlkYXRlX2RheF9wZm4ocGZuX3QgcGZuKQogCQkgKi8KIAkJV0FSTl9PTihJU19FTkFCTEVEKENP
TkZJR19BUkNIX0hBU19QTUVNX0FQSSkpOwogCQlkYXhfZW5hYmxlZCA9IHRydWU7Ci0JfSBlbHNl
IGlmIChwZm5fdF9kZXZtYXAocGZuKSkgeworCX0gZWxzZSBpZiAocGZuX3RfZGV2bWFwKCpwZm4p
KSB7CiAJCXN0cnVjdCBkZXZfcGFnZW1hcCAqcGdtYXA7CiAKLQkJcGdtYXAgPSBnZXRfZGV2X3Bh
Z2VtYXAocGZuX3RfdG9fcGZuKHBmbiksIE5VTEwpOworCQlwZ21hcCA9IGdldF9kZXZfcGFnZW1h
cChwZm5fdF90b19wZm4oKnBmbiksIE5VTEwpOwogCQlpZiAocGdtYXAgJiYgcGdtYXAtPnR5cGUg
PT0gTUVNT1JZX0RFVklDRV9GU19EQVgpCiAJCQlkYXhfZW5hYmxlZCA9IHRydWU7CiAJCXB1dF9k
ZXZfcGFnZW1hcChwZ21hcCk7CkBAIC0xMjAsMTAgKzEyMCwxMCBAQCBzdGF0aWMgYm9vbCB2YWxp
ZGF0ZV9kYXhfcGZuKHBmbl90IHBmbikKIGJvb2wgX19iZGV2X2RheF9zdXBwb3J0ZWQoc3RydWN0
IGJsb2NrX2RldmljZSAqYmRldiwgaW50IGJsb2Nrc2l6ZSkKIHsKIAlzdHJ1Y3QgZGF4X2Rldmlj
ZSAqZGF4X2RldjsKKwlwZm5fdCBfcGZuLCAqcGZuOwogCXBnb2ZmX3QgcGdvZmY7CiAJaW50IGVy
ciwgaWQ7CiAJdm9pZCAqa2FkZHI7Ci0JcGZuX3QgcGZuOwogCWxvbmcgbGVuOwogCWNoYXIgYnVm
W0JERVZOQU1FX1NJWkVdOwogCkBAIC0xNDcsOCArMTQ3LDEzIEBAIGJvb2wgX19iZGV2X2RheF9z
dXBwb3J0ZWQoc3RydWN0IGJsb2NrX2RldmljZSAqYmRldiwgaW50IGJsb2Nrc2l6ZSkKIAkJcmV0
dXJuIGZhbHNlOwogCX0KIAorCWlmIChJU19FTkFCTEVEKERBWF9EUklWRVJfREVCVUcpKQorCQlw
Zm4gPSAmX3BmbjsKKwllbHNlCisJCXBmbiA9IE5VTEw7CisKIAlpZCA9IGRheF9yZWFkX2xvY2so
KTsKLQlsZW4gPSBkYXhfZGlyZWN0X2FjY2VzcyhkYXhfZGV2LCBwZ29mZiwgMSwgJmthZGRyLCAm
cGZuKTsKKwlsZW4gPSBkYXhfZGlyZWN0X2FjY2VzcyhkYXhfZGV2LCBwZ29mZiwgMSwgJmthZGRy
LCBwZm4pOwogCWRheF9yZWFkX3VubG9jayhpZCk7CiAKIAlwdXRfZGF4KGRheF9kZXYpOwpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9udmRpbW0vcG1lbS5jIGIvZHJpdmVycy9udmRpbW0vcG1lbS5jCmlu
ZGV4IGU4YWM2ZjI0NGQyYi4uYzQzMDUzNjMyMGE1IDEwMDY0NAotLS0gYS9kcml2ZXJzL252ZGlt
bS9wbWVtLmMKKysrIGIvZHJpdmVycy9udmRpbW0vcG1lbS5jCkBAIC0yMjgsNyArMjI4LDggQEAg
X193ZWFrIGxvbmcgX19wbWVtX2RpcmVjdF9hY2Nlc3Moc3RydWN0IHBtZW1fZGV2aWNlICpwbWVt
LCBwZ29mZl90IHBnb2ZmLAogCQkJCQlQRk5fUEhZUyhucl9wYWdlcykpKSkKIAkJcmV0dXJuIC1F
SU87CiAJKmthZGRyID0gcG1lbS0+dmlydF9hZGRyICsgb2Zmc2V0OwotCSpwZm4gPSBwaHlzX3Rv
X3Bmbl90KHBtZW0tPnBoeXNfYWRkciArIG9mZnNldCwgcG1lbS0+cGZuX2ZsYWdzKTsKKwlpZiAo
cGZuKQorCQkqcGZuID0gcGh5c190b19wZm5fdChwbWVtLT5waHlzX2FkZHIgKyBvZmZzZXQsIHBt
ZW0tPnBmbl9mbGFncyk7CiAKIAkvKgogCSAqIElmIGJhZGJsb2NrcyBhcmUgcHJlc2VudCwgbGlt
aXQga25vd24gZ29vZCByYW5nZSB0byB0aGUKZGlmZiAtLWdpdCBhL2RyaXZlcnMvczM5MC9ibG9j
ay9kY3NzYmxrLmMgYi9kcml2ZXJzL3MzOTAvYmxvY2svZGNzc2Jsay5jCmluZGV4IGVkNjA3Mjg4
ZTY5Ni4uYTY0NWIyYzkzYzM0IDEwMDY0NAotLS0gYS9kcml2ZXJzL3MzOTAvYmxvY2svZGNzc2Js
ay5jCisrKyBiL2RyaXZlcnMvczM5MC9ibG9jay9kY3NzYmxrLmMKQEAgLTkyMyw4ICs5MjMsOSBA
QCBfX2Rjc3NibGtfZGlyZWN0X2FjY2VzcyhzdHJ1Y3QgZGNzc2Jsa19kZXZfaW5mbyAqZGV2X2lu
Zm8sIHBnb2ZmX3QgcGdvZmYsCiAKIAlkZXZfc3ogPSBkZXZfaW5mby0+ZW5kIC0gZGV2X2luZm8t
PnN0YXJ0ICsgMTsKIAkqa2FkZHIgPSAodm9pZCAqKSBkZXZfaW5mby0+c3RhcnQgKyBvZmZzZXQ7
Ci0JKnBmbiA9IF9fcGZuX3RvX3Bmbl90KFBGTl9ET1dOKGRldl9pbmZvLT5zdGFydCArIG9mZnNl
dCksCi0JCQlQRk5fREVWfFBGTl9TUEVDSUFMKTsKKwlpZiAocGZuKQorCQkqcGZuID0gX19wZm5f
dG9fcGZuX3QoUEZOX0RPV04oZGV2X2luZm8tPnN0YXJ0ICsgb2Zmc2V0KSwKKwkJCQlQRk5fREVW
fFBGTl9TUEVDSUFMKTsKIAogCXJldHVybiAoZGV2X3N6IC0gb2Zmc2V0KSAvIFBBR0VfU0laRTsK
IH0KZGlmZiAtLWdpdCBhL2ZzL2RheC5jIGIvZnMvZGF4LmMKaW5kZXggNjQxMTkyODA4YmI2Li4y
ODI2NGZmNGUzNDMgMTAwNjQ0Ci0tLSBhL2ZzL2RheC5jCisrKyBiL2ZzL2RheC5jCkBAIC02NDcs
NyArNjQ3LDYgQEAgc3RhdGljIGludCBjb3B5X3VzZXJfZGF4KHN0cnVjdCBibG9ja19kZXZpY2Ug
KmJkZXYsIHN0cnVjdCBkYXhfZGV2aWNlICpkYXhfZGV2LAogewogCXZvaWQgKnZ0bywgKmthZGRy
OwogCXBnb2ZmX3QgcGdvZmY7Ci0JcGZuX3QgcGZuOwogCWxvbmcgcmM7CiAJaW50IGlkOwogCkBA
IC02NTYsNyArNjU1LDcgQEAgc3RhdGljIGludCBjb3B5X3VzZXJfZGF4KHN0cnVjdCBibG9ja19k
ZXZpY2UgKmJkZXYsIHN0cnVjdCBkYXhfZGV2aWNlICpkYXhfZGV2LAogCQlyZXR1cm4gcmM7CiAK
IAlpZCA9IGRheF9yZWFkX2xvY2soKTsKLQlyYyA9IGRheF9kaXJlY3RfYWNjZXNzKGRheF9kZXYs
IHBnb2ZmLCBQSFlTX1BGTihzaXplKSwgJmthZGRyLCAmcGZuKTsKKwlyYyA9IGRheF9kaXJlY3Rf
YWNjZXNzKGRheF9kZXYsIHBnb2ZmLCBQSFlTX1BGTihzaXplKSwgJmthZGRyLCBOVUxMKTsKIAlp
ZiAocmMgPCAwKSB7CiAJCWRheF9yZWFkX3VubG9jayhpZCk7CiAJCXJldHVybiByYzsKQEAgLTEw
NTIsMTUgKzEwNTEsMTMgQEAgaW50IF9fZGF4X3plcm9fcGFnZV9yYW5nZShzdHJ1Y3QgYmxvY2tf
ZGV2aWNlICpiZGV2LAogCQlwZ29mZl90IHBnb2ZmOwogCQlsb25nIHJjLCBpZDsKIAkJdm9pZCAq
a2FkZHI7Ci0JCXBmbl90IHBmbjsKIAogCQlyYyA9IGJkZXZfZGF4X3Bnb2ZmKGJkZXYsIHNlY3Rv
ciwgUEFHRV9TSVpFLCAmcGdvZmYpOwogCQlpZiAocmMpCiAJCQlyZXR1cm4gcmM7CiAKIAkJaWQg
PSBkYXhfcmVhZF9sb2NrKCk7Ci0JCXJjID0gZGF4X2RpcmVjdF9hY2Nlc3MoZGF4X2RldiwgcGdv
ZmYsIDEsICZrYWRkciwKLQkJCQkmcGZuKTsKKwkJcmMgPSBkYXhfZGlyZWN0X2FjY2VzcyhkYXhf
ZGV2LCBwZ29mZiwgMSwgJmthZGRyLCBOVUxMKTsKIAkJaWYgKHJjIDwgMCkgewogCQkJZGF4X3Jl
YWRfdW5sb2NrKGlkKTsKIAkJCXJldHVybiByYzsKQEAgLTExMTYsNyArMTExMyw2IEBAIGRheF9p
b21hcF9hY3RvcihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBsb2ZmX3QgcG9zLCBsb2ZmX3QgbGVuZ3Ro
LCB2b2lkICpkYXRhLAogCQlzc2l6ZV90IG1hcF9sZW47CiAJCXBnb2ZmX3QgcGdvZmY7CiAJCXZv
aWQgKmthZGRyOwotCQlwZm5fdCBwZm47CiAKIAkJaWYgKGZhdGFsX3NpZ25hbF9wZW5kaW5nKGN1
cnJlbnQpKSB7CiAJCQlyZXQgPSAtRUlOVFI7CkBAIC0xMTI4LDcgKzExMjQsNyBAQCBkYXhfaW9t
YXBfYWN0b3Ioc3RydWN0IGlub2RlICppbm9kZSwgbG9mZl90IHBvcywgbG9mZl90IGxlbmd0aCwg
dm9pZCAqZGF0YSwKIAkJCWJyZWFrOwogCiAJCW1hcF9sZW4gPSBkYXhfZGlyZWN0X2FjY2Vzcyhk
YXhfZGV2LCBwZ29mZiwgUEhZU19QRk4oc2l6ZSksCi0JCQkJJmthZGRyLCAmcGZuKTsKKwkJCQkm
a2FkZHIsIE5VTEwpOwogCQlpZiAobWFwX2xlbiA8IDApIHsKIAkJCXJldCA9IG1hcF9sZW47CiAJ
CQlicmVhazsKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3RpbmcvbnZkaW1tL3BtZW0tZGF4LmMgYi90
b29scy90ZXN0aW5nL252ZGltbS9wbWVtLWRheC5jCmluZGV4IGI1MzU5NmFkNjAxYi4uZDRjYjUy
ODFiMzBlIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL252ZGltbS9wbWVtLWRheC5jCisrKyBi
L3Rvb2xzL3Rlc3RpbmcvbnZkaW1tL3BtZW0tZGF4LmMKQEAgLTMzLDcgKzMzLDggQEAgbG9uZyBf
X3BtZW1fZGlyZWN0X2FjY2VzcyhzdHJ1Y3QgcG1lbV9kZXZpY2UgKnBtZW0sIHBnb2ZmX3QgcGdv
ZmYsCiAKIAkJKmthZGRyID0gcG1lbS0+dmlydF9hZGRyICsgb2Zmc2V0OwogCQlwYWdlID0gdm1h
bGxvY190b19wYWdlKHBtZW0tPnZpcnRfYWRkciArIG9mZnNldCk7Ci0JCSpwZm4gPSBwYWdlX3Rv
X3Bmbl90KHBhZ2UpOworCQlpZiAocGZuKQorCQkJKnBmbiA9IHBhZ2VfdG9fcGZuX3QocGFnZSk7
CiAJCXByX2RlYnVnX3JhdGVsaW1pdGVkKCIlczogcG1lbTogJXAgcGdvZmY6ICUjbHggcGZuOiAl
I2x4XG4iLAogCQkJCV9fZnVuY19fLCBwbWVtLCBwZ29mZiwgcGFnZV90b19wZm4ocGFnZSkpOwog
CkBAIC00MSw3ICs0Miw4IEBAIGxvbmcgX19wbWVtX2RpcmVjdF9hY2Nlc3Moc3RydWN0IHBtZW1f
ZGV2aWNlICpwbWVtLCBwZ29mZl90IHBnb2ZmLAogCX0KIAogCSprYWRkciA9IHBtZW0tPnZpcnRf
YWRkciArIG9mZnNldDsKLQkqcGZuID0gcGh5c190b19wZm5fdChwbWVtLT5waHlzX2FkZHIgKyBv
ZmZzZXQsIHBtZW0tPnBmbl9mbGFncyk7CisJaWYgKHBmbikKKwkJKnBmbiA9IHBoeXNfdG9fcGZu
X3QocG1lbS0+cGh5c19hZGRyICsgb2Zmc2V0LCBwbWVtLT5wZm5fZmxhZ3MpOwogCiAJLyoKIAkg
KiBJZiBiYWRibG9ja3MgYXJlIHByZXNlbnQsIGxpbWl0IGtub3duIGdvb2QgcmFuZ2UgdG8gdGhl
Ci0tIAoyLjEzLjYKCg==
--00000000000078b3a005702d5f0a--
