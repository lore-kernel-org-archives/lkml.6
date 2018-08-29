Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F3FC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0E42064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEl7t/ek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0E42064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbeH3AXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:23:16 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40733 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbeH3AXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:23:15 -0400
Received: by mail-oi0-f67.google.com with SMTP id l202-v6so11480553oig.7;
        Wed, 29 Aug 2018 13:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MBPzH2GiAZ9Zo6WSTAxnLyw6LTgMuB0lIKYfvyO+OiE=;
        b=JEl7t/ek+81epMigIBt93j2nArFoRX1SwtwQdW1gjSAqDfc4BG6rL25DDRR/84MxhB
         K1wQdD5CONuxMziUcOgdZIKAy2AcCN2LgH1qiajgaoppY5wWy0Lio7CFjKf+NOvgYXQE
         DvM5vOdlJ7giN9/K0yyyd8ARAeUROWTxcQDZxHtxXVEzzaBS+K1vnz9C7Z5SEGTparOE
         YROZIqhQASfifM5Z/EYg7EceAPoDKD/KG/SmpEp+PhCa2Uzx/eYsX5h2tU3RvWsZqn9g
         rSwFQcfZjSxbI24UAKjB4YwRhRVSoCEkyxVsQn/wjVEbkAEovbaAiKLQRWNlQSG/Faax
         6YQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MBPzH2GiAZ9Zo6WSTAxnLyw6LTgMuB0lIKYfvyO+OiE=;
        b=q/kU3rYlSyDgByNk9xO5UtNE+maX73etT7Ntyqt0FqFezol5vfpMvSVJyX7OP6Urvq
         Z5DDFYjWrT9robsjvdygqtjC/7qm8ZLOMowAX850ARjyrtZ9HPtjMQHZ2pD3fhufmJzt
         XcUybgVwAnEyYUIKmqy8hZq+x9d6iJfJswNly35B4cetiroiCumubKHQOJocgqhmxtha
         AVrPKUZhghVvttSFpvSMMduoQQGp2OwPRSV4UtZCOHdc96cc8U/CEOLtbOa5UUsMUD5O
         3EPetKhywqVhgmLA969af10xvcYqbPfm9V/H74oCGz5z495wALtYcCzU9xtRY9zxLlWO
         kaSg==
X-Gm-Message-State: APzg51ADa5P7/jgQlnKoH7PelIoBeHofuXilXYERGv/3CXhpJSWAqTtL
        TJN1slgEInc0c8XkA8pAJ562xMe3sAsGlg0UGY4=
X-Google-Smtp-Source: ANB0VdaOLQ2Pc/5EuZMlOY4dOGDUCLUc743NE4+2gBGdVp9+ja7CfSOFjIik59nHpq/kBJ2P1xaxLQup0yDn5+dafWg=
X-Received: by 2002:aca:d986:: with SMTP id q128-v6mr3966956oig.349.1535573842610;
 Wed, 29 Aug 2018 13:17:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:284e:0:0:0:0:0 with HTTP; Wed, 29 Aug 2018 13:17:22
 -0700 (PDT)
In-Reply-To: <CAOMZO5Bvj=kB8m7DcX2vSLr3e0_uW-CnURtwM71YJ=NWT+DCgQ@mail.gmail.com>
References: <b2ea002f-4fe8-0738-b346-69ed138cecd0@prevas.dk>
 <b2505963-0fdc-81d2-6b8a-315a31eb922e@prevas.dk> <AM6PR04MB5158CB868A4E2AD5AFC5B476E3090@AM6PR04MB5158.eurprd04.prod.outlook.com>
 <CAOMZO5Bvj=kB8m7DcX2vSLr3e0_uW-CnURtwM71YJ=NWT+DCgQ@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 29 Aug 2018 17:17:22 -0300
Message-ID: <CAOMZO5BmSe17weXbZdbqxStQj8XSYJiGvX6me0y=VP5TP-6Qng@mail.gmail.com>
Subject: Re: reboot on wandboard fails with v4.14.67 (bisected to 2059e527a6)
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable <stable@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Content-Type: multipart/mixed; boundary="0000000000006a7e4e057498a5a9"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000006a7e4e057498a5a9
Content-Type: text/plain; charset="UTF-8"

Hi Rasmus,

On Wed, Aug 29, 2018 at 10:57 AM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Rasmus,
>
>> On 2018-08-29 11:55, Rasmus Villemoes wrote:
>>> We're using imx_v6_v7_defconfig on our Wandboards. After upgrading to
>>> v4.14.67, reboot no longer works (or, well, takes a very long time when
>>> the watchdog is configured).
>>>
>>> v4.14.66 works fine, the breakage bisects to
>>> 2059e527a659cf16d6bb709f1c8509f7a7623fc4 (ARM: imx_v6_v7_defconfig:
>>> Select ULPI support), and reverting that on top of v4.14.67 again works.
>>
>> FWIW, v4.18 (the mainline release containing the upstream commit
>> 157bcc0609) works fine, while v4.17.19 which also has that commit
>> backported (as df06ca1f56) fails. So I'm guessing there must be some
>> other commits in v4.18 that happen to make imx_v6_v7_defconfig work.
>
> Thanks for reporting.
>
> Commit 157bcc06094c3 ("ARM: imx_v6_v7_defconfig: Select ULPI support")
> was meant to be applied for 4.18 only.
>
> I think we should revert it from earlier stable versions.

Or a better solution would be to port
a930d8bd94d8db7715d1af74299f710b1fb22fc8 from upstream.

Please test the attached patch adjusted for 4.14.67.

Thanks

--0000000000006a7e4e057498a5a9
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-usb-chipidea-Always-build-ULPI-code.patch"
Content-Disposition: attachment; 
	filename="0001-usb-chipidea-Always-build-ULPI-code.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jlfl18tb0

RnJvbSA0NzVhMDMwMTExNmM0ODUzZTRiMzdhYmYwODFlZDI1ZDY3MDZjNzllIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGYWJpbyBFc3RldmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+
CkRhdGU6IFdlZCwgMjkgQXVnIDIwMTggMTc6MTM6MzMgLTAzMDAKU3ViamVjdDogW1BBVENIXSB1
c2I6IGNoaXBpZGVhOiBBbHdheXMgYnVpbGQgVUxQSSBjb2RlCgpbY29tbWl0IGE5MzBkOGJkOTRk
OGRiNzcxNWQxYWY3NDI5OWY3MTBiMWZiMjJmYzggdXBzdHJlYW1dCgpDb21taXQgMDNlNjI3NWFl
MzgxICgidXNiOiBjaGlwaWRlYTogRml4IFVMUEkgb24gaW14NTEiKSBjYXVzZXMgYSBrZXJuZWwK
aGFuZyBvbiBpbXg1MSBzeXN0ZW1zIHRoYXQgdXNlIHRoZSBVTFBJIGludGVyZmFjZSBhbmQgZG8g
bm90IHNlbGVjdCB0aGUKQ09ORklHX1VTQl9DSElQSURFQV9VTFBJIG9wdGlvbi4KCkluIG9yZGVy
IHRvIGF2b2lkIHN1Y2ggcG90ZW50aWFsIG1pc3VzZSwgbGV0J3MgYWx3YXlzIGJ1aWxkIHRoZQpj
aGlwaWRlYSBVTFBJIGNvZGUgaW50byB0aGUgZmluYWwgY2lfaGRyYyBvYmplY3QuCgpUZXN0ZWQg
b24gYSBpbXg1MS1iYWJiYWdlIGJvYXJkLgoKRml4ZXM6IDAzZTYyNzVhZTM4MSAoInVzYjogY2hp
cGlkZWE6IEZpeCBVTFBJIG9uIGlteDUxIikKU2lnbmVkLW9mZi1ieTogRmFiaW8gRXN0ZXZhbSA8
ZmFiaW8uZXN0ZXZhbUBueHAuY29tPgotLS0KIGRyaXZlcnMvdXNiL2NoaXBpZGVhL0tjb25maWcg
IHwgOSArLS0tLS0tLS0KIGRyaXZlcnMvdXNiL2NoaXBpZGVhL01ha2VmaWxlIHwgMyArLS0KIGRy
aXZlcnMvdXNiL2NoaXBpZGVhL2NpLmggICAgIHwgOCAtLS0tLS0tLQogZHJpdmVycy91c2IvY2hp
cGlkZWEvdWxwaS5jICAgfCAzICsrKwogNCBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyks
IDE4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NoaXBpZGVhL0tjb25m
aWcgYi9kcml2ZXJzL3VzYi9jaGlwaWRlYS9LY29uZmlnCmluZGV4IDUxZjQxNTcuLjZkOTkwZTQg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdXNiL2NoaXBpZGVhL0tjb25maWcKKysrIGIvZHJpdmVycy91
c2IvY2hpcGlkZWEvS2NvbmZpZwpAQCAtMyw2ICszLDcgQEAgY29uZmlnIFVTQl9DSElQSURFQQog
CWRlcGVuZHMgb24gKChVU0JfRUhDSV9IQ0QgJiYgVVNCX0dBREdFVCkgfHwgKFVTQl9FSENJX0hD
RCAmJiAhVVNCX0dBREdFVCkgfHwgKCFVU0JfRUhDSV9IQ0QgJiYgVVNCX0dBREdFVCkpICYmIEhB
U19ETUEKIAlzZWxlY3QgRVhUQ09OCiAJc2VsZWN0IFJFU0VUX0NPTlRST0xMRVIKKwlzZWxlY3Qg
VVNCX1VMUElfQlVTCiAJaGVscAogCSAgU2F5IFkgaGVyZSBpZiB5b3VyIHN5c3RlbSBoYXMgYSBk
dWFsIHJvbGUgaGlnaCBzcGVlZCBVU0IKIAkgIGNvbnRyb2xsZXIgYmFzZWQgb24gQ2hpcElkZWEg
c2lsaWNvbiBJUC4gSXQgc3VwcG9ydHM6CkBAIC0zOCwxMiArMzksNCBAQCBjb25maWcgVVNCX0NI
SVBJREVBX0hPU1QKIAloZWxwCiAJICBTYXkgWSBoZXJlIHRvIGVuYWJsZSBob3N0IGNvbnRyb2xs
ZXIgZnVuY3Rpb25hbGl0eSBvZiB0aGUKIAkgIENoaXBJZGVhIGRyaXZlci4KLQotY29uZmlnIFVT
Ql9DSElQSURFQV9VTFBJCi0JYm9vbCAiQ2hpcElkZWEgVUxQSSBQSFkgc3VwcG9ydCIKLQlkZXBl
bmRzIG9uIFVTQl9VTFBJX0JVUz15IHx8IFVTQl9VTFBJX0JVUz1VU0JfQ0hJUElERUEKLQloZWxw
Ci0JICBTYXkgWSBoZXJlIGlmIHlvdSBoYXZlIGEgVUxQSSBQSFkgYXR0YWNoZWQgdG8geW91ciBD
aGlwSWRlYQotCSAgY29udHJvbGxlci4KLQogZW5kaWYKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNi
L2NoaXBpZGVhL01ha2VmaWxlIGIvZHJpdmVycy91c2IvY2hpcGlkZWEvTWFrZWZpbGUKaW5kZXgg
ZTNkNWU3Mi4uMTJkZjk0ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy91c2IvY2hpcGlkZWEvTWFrZWZp
bGUKKysrIGIvZHJpdmVycy91c2IvY2hpcGlkZWEvTWFrZWZpbGUKQEAgLTEsMTEgKzEsMTAgQEAK
ICMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKIG9iai0kKENPTkZJR19VU0JfQ0hJ
UElERUEpCQkrPSBjaV9oZHJjLm8KIAotY2lfaGRyYy15CQkJCTo9IGNvcmUubyBvdGcubyBkZWJ1
Zy5vCitjaV9oZHJjLXkJCQkJOj0gY29yZS5vIG90Zy5vIGRlYnVnLm8gdWxwaS5vCiBjaV9oZHJj
LSQoQ09ORklHX1VTQl9DSElQSURFQV9VREMpCSs9IHVkYy5vCiBjaV9oZHJjLSQoQ09ORklHX1VT
Ql9DSElQSURFQV9IT1NUKQkrPSBob3N0Lm8KIGNpX2hkcmMtJChDT05GSUdfVVNCX09UR19GU00p
CQkrPSBvdGdfZnNtLm8KLWNpX2hkcmMtJChDT05GSUdfVVNCX0NISVBJREVBX1VMUEkpCSs9IHVs
cGkubwogCiAjIEdsdWUvQnJpZGdlIGxheWVycyBnbyBoZXJlCiAKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2NoaXBpZGVhL2NpLmggYi9kcml2ZXJzL3VzYi9jaGlwaWRlYS9jaS5oCmluZGV4IDY3
NDNmODUuLjYxYWVlMmIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdXNiL2NoaXBpZGVhL2NpLmgKKysr
IGIvZHJpdmVycy91c2IvY2hpcGlkZWEvY2kuaApAQCAtMjQzLDEwICsyNDMsOCBAQCBzdHJ1Y3Qg
Y2lfaGRyYyB7CiAKIAlzdHJ1Y3QgY2lfaGRyY19wbGF0Zm9ybV9kYXRhCSpwbGF0ZGF0YTsKIAlp
bnQJCQkJdmJ1c19hY3RpdmU7Ci0jaWZkZWYgQ09ORklHX1VTQl9DSElQSURFQV9VTFBJCiAJc3Ry
dWN0IHVscGkJCQkqdWxwaTsKIAlzdHJ1Y3QgdWxwaV9vcHMgCQl1bHBpX29wczsKLSNlbmRpZgog
CXN0cnVjdCBwaHkJCQkqcGh5OwogCS8qIG9sZCB1c2JfcGh5IGludGVyZmFjZSAqLwogCXN0cnVj
dCB1c2JfcGh5CQkJKnVzYl9waHk7CkBAIC00MjksMTUgKzQyNyw5IEBAIHN0YXRpYyBpbmxpbmUg
Ym9vbCBjaV9vdGdfaXNfZnNtX21vZGUoc3RydWN0IGNpX2hkcmMgKmNpKQogI2VuZGlmCiB9CiAK
LSNpZiBJU19FTkFCTEVEKENPTkZJR19VU0JfQ0hJUElERUFfVUxQSSkKIGludCBjaV91bHBpX2lu
aXQoc3RydWN0IGNpX2hkcmMgKmNpKTsKIHZvaWQgY2lfdWxwaV9leGl0KHN0cnVjdCBjaV9oZHJj
ICpjaSk7CiBpbnQgY2lfdWxwaV9yZXN1bWUoc3RydWN0IGNpX2hkcmMgKmNpKTsKLSNlbHNlCi1z
dGF0aWMgaW5saW5lIGludCBjaV91bHBpX2luaXQoc3RydWN0IGNpX2hkcmMgKmNpKSB7IHJldHVy
biAwOyB9Ci1zdGF0aWMgaW5saW5lIHZvaWQgY2lfdWxwaV9leGl0KHN0cnVjdCBjaV9oZHJjICpj
aSkgeyB9Ci1zdGF0aWMgaW5saW5lIGludCBjaV91bHBpX3Jlc3VtZShzdHJ1Y3QgY2lfaGRyYyAq
Y2kpIHsgcmV0dXJuIDA7IH0KLSNlbmRpZgogCiB1MzIgaHdfcmVhZF9pbnRyX2VuYWJsZShzdHJ1
Y3QgY2lfaGRyYyAqY2kpOwogCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9jaGlwaWRlYS91bHBp
LmMgYi9kcml2ZXJzL3VzYi9jaGlwaWRlYS91bHBpLmMKaW5kZXggMTIxOTU4My4uZjY1MjEzMiAx
MDA2NDQKLS0tIGEvZHJpdmVycy91c2IvY2hpcGlkZWEvdWxwaS5jCisrKyBiL2RyaXZlcnMvdXNi
L2NoaXBpZGVhL3VscGkuYwpAQCAtMTAzLDYgKzEwMyw5IEBAIGludCBjaV91bHBpX3Jlc3VtZShz
dHJ1Y3QgY2lfaGRyYyAqY2kpCiB7CiAJaW50IGNudCA9IDEwMDAwMDsKIAorCWlmIChjaS0+cGxh
dGRhdGEtPnBoeV9tb2RlICE9IFVTQlBIWV9JTlRFUkZBQ0VfTU9ERV9VTFBJKQorCQlyZXR1cm4g
MDsKKwogCXdoaWxlIChjbnQtLSA+IDApIHsKIAkJaWYgKGh3X3JlYWQoY2ksIE9QX1VMUElfVklF
V1BPUlQsIFVMUElfU1lOQ19TVEFURSkpCiAJCQlyZXR1cm4gMDsKLS0gCjIuNy40Cgo=
--0000000000006a7e4e057498a5a9--
