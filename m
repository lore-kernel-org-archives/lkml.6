Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +ULWJd5GHFunegAAmS7hNA
	; Sat, 09 Jun 2018 21:30:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7DF8F608B8; Sat,  9 Jun 2018 21:30:06 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Na6V6Reb"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 945A4605A5;
	Sat,  9 Jun 2018 21:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 945A4605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753429AbeFIVaD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 17:30:03 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:37652 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753262AbeFIVaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 17:30:00 -0400
Received: by mail-ot0-f194.google.com with SMTP id 101-v6so19656748oth.4;
        Sat, 09 Jun 2018 14:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=U1dMV4IdJJYpYmvZ6JDLAbwW1TRdsMbeZWZjZsV2yyo=;
        b=Na6V6Rebte8jZfvOp1XS3dqSximNS2N+eyfnW/QAipD67cEDDoLeyJhxqKQuIdQpFZ
         MeGYrrYWPLrxDlvgdjVidOROrrX+OB1GYYNTBoItslExDnZ50XgZTfSbcqL8VgUnIfjq
         pKqi+yQzACtHtb8UX5Fa0P6lypEQWPhbcAzZOZEb+7ELi0wViy7SGzduGE7dQlQcdTKa
         VeRMfC4SZ83gWht9k922OfLNAydVZHSbB/1DSxvpzkYyNYafbFVW4F752LTC5DQzKQyg
         heFOM8D7mIGvuGjtOzw7mX2JjuI5t5EA6Dcr//bXbE/U+g5SDaK/CNR2qPrbxCEP2CuQ
         M/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=U1dMV4IdJJYpYmvZ6JDLAbwW1TRdsMbeZWZjZsV2yyo=;
        b=irVwfylr8D7pxUpYehHCLMwRajg0sR2Lo3Z8nG5bgReiVR/iDgGNjhtVOjmUCUk1L7
         F2vYV1ac8YCfZ5BFIskQoOaFFrgjkKyhl7j82Aw2l3EFbGP5o1YRLtr/imW1Q7JwZwgy
         FHgN1FzwFs9HXxJTkJffhyeQOA3xlIWZDpHG1wlSoJSo9FdC4HnVNuN/hGxea7fyagWQ
         LNTRqJGxZwTFnAPg9ipX7W9FZDvbtE9YR/gbiKz+NevEO1AlmPeMVD7x3WkicCPzyt8P
         l8G4riMy1Ql+RjhYUaHIBztroPP1ydaUN6Y8xHwMjqeFsoGmi2uwO75lfTC2qkFvhdGs
         Pwmw==
X-Gm-Message-State: APt69E1TLmaLFbcJeVHBR06ZqhjVNdNAZr2pPW95WamfYJ328pjclC5z
        1TS5MSO7v0oqhia/1GcdentoVnNapXlhj2S529c=
X-Google-Smtp-Source: ADUXVKJgvosU/WYPGQtYOv2S88FbJ6pNVVuHp2d0TTJ3EgnWk82Z4jMQchI1gU+n4C2MAFyPe92iqsC270BG8IGhz7E=
X-Received: by 2002:a9d:368a:: with SMTP id h10-v6mr6299510otc.19.1528579799957;
 Sat, 09 Jun 2018 14:29:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:eae:0:0:0:0:0 with HTTP; Sat, 9 Jun 2018 14:29:59 -0700 (PDT)
Reply-To: mceier@gmail.com
In-Reply-To: <20180522201006.14003-1-rodrigorivascosta@gmail.com>
References: <20180522201006.14003-1-rodrigorivascosta@gmail.com>
From: Mariusz Ceier <mceier@gmail.com>
Date: Sat, 9 Jun 2018 23:29:59 +0200
Message-ID: <CAJTyqKNYbsH1LS9Eo9sKL5Cg_+00-aBObQ2vhnA3rtHQvaPgug@mail.gmail.com>
Subject: Re: [PATCH] HID: steam: use hid_device.driver_data instead of hid_set_drvdata()
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000fcf645056e3c37a3"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000fcf645056e3c37a3
Content-Type: text/plain; charset="UTF-8"

Hello Rodrigo,
   I confirm that this patch fixes the steam controller related crash
for me. I don't know if it's correct, but at least it's:

Tested-by: Mariusz Ceier <mceier+kernel@gmail.com>

I'm attaching the backtrace of crash I was getting before applying the patch.

Best regards,
Mariusz Ceier


On 22 May 2018 at 22:10, Rodrigo Rivas Costa
<rodrigorivascosta@gmail.com> wrote:
> When creating the low-level hidraw device, the reference to steam_device
> was stored using hid_set_drvdata(). But this value is not guaranteed to
> be kept when set before calling probe. If this pointer is reset, it
> crashes when opening the emulated hidraw device.
>
> It looks like hid_set_drvdata() is for users "avobe" this hid_device,
> while hid_device.driver_data it for users "below" this one.
>
> In this case, we are creating a virtual hidraw device, so we must use
> hid_device.driver_data.
>
> Signed-off-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
> ---
>
> This patch is to be applied over hid/for-4.18/hid-steam. Is this the
> proper way to signal it?
>
> I don't know exactly when the problem started. I am pretty sure that it
> worked with 4.16.2, but it failed with 4.16.9. Or maybe it is caused by
> upgrading the firmware of the controller, although the protocol seems
> identical.
>
>  drivers/hid/hid-steam.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index cb86cc834201..0422ec2b13d2 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -573,7 +573,7 @@ static bool steam_is_valve_interface(struct hid_device *hdev)
>
>  static int steam_client_ll_parse(struct hid_device *hdev)
>  {
> -       struct steam_device *steam = hid_get_drvdata(hdev);
> +       struct steam_device *steam = hdev->driver_data;
>
>         return hid_parse_report(hdev, steam->hdev->dev_rdesc,
>                         steam->hdev->dev_rsize);
> @@ -590,7 +590,7 @@ static void steam_client_ll_stop(struct hid_device *hdev)
>
>  static int steam_client_ll_open(struct hid_device *hdev)
>  {
> -       struct steam_device *steam = hid_get_drvdata(hdev);
> +       struct steam_device *steam = hdev->driver_data;
>         int ret;
>
>         ret = hid_hw_open(steam->hdev);
> @@ -605,7 +605,7 @@ static int steam_client_ll_open(struct hid_device *hdev)
>
>  static void steam_client_ll_close(struct hid_device *hdev)
>  {
> -       struct steam_device *steam = hid_get_drvdata(hdev);
> +       struct steam_device *steam = hdev->driver_data;
>
>         mutex_lock(&steam->mutex);
>         steam->client_opened = false;
> @@ -623,7 +623,7 @@ static int steam_client_ll_raw_request(struct hid_device *hdev,
>                                 size_t count, unsigned char report_type,
>                                 int reqtype)
>  {
> -       struct steam_device *steam = hid_get_drvdata(hdev);
> +       struct steam_device *steam = hdev->driver_data;
>
>         return hid_hw_raw_request(steam->hdev, reportnum, buf, count,
>                         report_type, reqtype);
> @@ -710,7 +710,7 @@ static int steam_probe(struct hid_device *hdev,
>                 ret = PTR_ERR(steam->client_hdev);
>                 goto client_hdev_fail;
>         }
> -       hid_set_drvdata(steam->client_hdev, steam);
> +       steam->client_hdev->driver_data = steam;
>
>         /*
>          * With the real steam controller interface, do not connect hidraw.
> --
> 2.17.0
>

--000000000000fcf645056e3c37a3
Content-Type: text/plain; charset="US-ASCII"; name="steam_backtrace.txt"
Content-Disposition: attachment; filename="steam_backtrace.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ji7wx2au0

WyA0MDA0Ljg2NjQ3MV0gQlVHOiB1bmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIg
ZGVyZWZlcmVuY2UgYXQgMDAwMDAwMDAwMDAwMDAxOApbIDQwMDQuODY2NDc1XSBQR0QgODAwMDAw
MDg2YWRlNTA2NyBQNEQgODAwMDAwMDg2YWRlNTA2NyBQVUQgMCAKWyA0MDA0Ljg2NjQ3OV0gT29w
czogMDAwMCBbIzFdIFBSRUVNUFQgU01QIFBUSQpbIDQwMDQuODY2NDgxXSBDUFU6IDIgUElEOiA0
ODg0IENvbW06IENTdGVhbUNvbnRyb2xsZSBUYWludGVkOiBHICAgICAgICBXICAgICAgICAgNC4x
Ny4wLWFtZGdwdS1kZXYrICMxClsgNDAwNC44NjY0ODJdIEhhcmR3YXJlIG5hbWU6IEdpZ2FieXRl
IFRlY2hub2xvZ3kgQ28uLCBMdGQuIFoxNzBYLUdhbWluZyA3L1oxNzBYLUdhbWluZyA3LCBCSU9T
IEYyMmogMDEvMTEvMjAxOApbIDQwMDQuODY2NDg2XSBSSVA6IDAwMTA6c3RlYW1fY2xpZW50X2xs
X29wZW4rMHgxNy8weDUwClsgNDAwNC44NjY0ODddIENvZGU6IGU4IDllIGNiIGUwIGZmIDRjIDg5
IGU3IGU4IGQ2IDZhIGZmIGZmIGViIGMwIDBmIDFmIDQwIDAwIGU4IDFiIDA5IDI2IDAwIDU1IDQ4
IDg5IGU1IDQxIDU0IDUzIDQ4IDgzIGVjIDA4IDQ4IDhiIDlmIDY4IDE5IDAwIDAwIDw0OD4gOGIg
N2IgMTggZTggNDAgNmEgZmYgZmYgODUgYzAgNzUgMWUgNGMgOGQgNjMgMjggODkgNDUgZWMgNGMg
ODkgClsgNDAwNC44NjY1MTBdIFJTUDogMDAxODpmZmZmYzBhODQxYTViYjE4IEVGTEFHUzogMDAw
MTAyOTYKWyA0MDA0Ljg2NjUxMV0gUkFYOiBmZmZmZmZmZmJkYmEwZDUwIFJCWDogMDAwMDAwMDAw
MDAwMDAwMCBSQ1g6IDAwMDAwMDAwMDAwMDAwMDEKWyA0MDA0Ljg2NjUxMl0gUkRYOiAwMDAwMDAw
MDAwMDAwMDAwIFJTSTogMDAwMDAwMDAwMDAwMDAwMCBSREk6IGZmZmY5Yzc3NzUyZWUwMDAKWyA0
MDA0Ljg2NjUxM10gUkJQOiBmZmZmYzBhODQxYTViYjMwIFIwODogZmZmZjljNzc3YTAwMmQ4MCBS
MDk6IGZmZmY5Yzc3NmIxNjk4MDAKWyA0MDA0Ljg2NjUxNF0gUjEwOiBmZmZmOWM3Nzc5YTFkMDI1
IFIxMTogMDAzNDc3NjE3MjY0Njk2OCBSMTI6IGZmZmY5Yzc3NzUyZWZiYTgKWyA0MDA0Ljg2NjUx
NV0gUjEzOiBmZmZmOWM3NzZkMjU2ZTAwIFIxNDogZmZmZjljNzc3NGMyYjBjMCBSMTU6IGZmZmZm
ZmZmYmQ0MTQ3NTAKWyA0MDA0Ljg2NjUxN10gRlM6ICAwMDAwMDAwMDAwMDAwMDAwKDAwMDApIEdT
OmZmZmY5Yzc3OWRkMDAwMDAoMDA2Mykga25sR1M6MDAwMDAwMDBlNjVjYWI0MApbIDQwMDQuODY2
NTE4XSBDUzogIDAwMTAgRFM6IDAwMmIgRVM6IDAwMmIgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzClsg
NDAwNC44NjY1MTldIENSMjogMDAwMDAwMDAwMDAwMDAxOCBDUjM6IDAwMDAwMDA4NjQ2MTQwMDQg
Q1I0OiAwMDAwMDAwMDAwMzYwNmUwClsgNDAwNC44NjY1MjFdIERSMDogMDAwMDAwMDAwMDAwMDAw
MCBEUjE6IDAwMDAwMDAwMDAwMDAwMDAgRFIyOiAwMDAwMDAwMDAwMDAwMDAwClsgNDAwNC44NjY1
MjJdIERSMzogMDAwMDAwMDAwMDAwMDAwMCBEUjY6IDAwMDAwMDAwZmZmZTBmZjAgRFI3OiAwMDAw
MDAwMDAwMDAwNDAwClsgNDAwNC44NjY1MjJdIENhbGwgVHJhY2U6ClsgNDAwNC44NjY1MjZdICA/
IGttZW1fY2FjaGVfYWxsb2NfdHJhY2UrMHgxNjkvMHgxYzAKWyA0MDA0Ljg2NjUyOF0gIGhpZF9o
d19vcGVuKzB4NGMvMHg3MApbIDQwMDQuODY2NTMwXSAgaGlkcmF3X29wZW4rMHhhZS8weDFkMApb
IDQwMDQuODY2NTMyXSAgPyBjZGV2X3B1dC5wYXJ0LjErMHgyMC8weDIwClsgNDAwNC44NjY1MzRd
ICBjaHJkZXZfb3BlbisweGE2LzB4MWMwClsgNDAwNC44NjY1MzZdICBkb19kZW50cnlfb3Blbisw
eDFiZC8weDJmMApbIDQwMDQuODY2NTM4XSAgdmZzX29wZW4rMHg0Zi8weDgwClsgNDAwNC44NjY1
NDBdICBkb19sYXN0KzB4NGRhLzB4MTI0MApbIDQwMDQuODY2NTQyXSAgPyBpbm9kZV9wZXJtaXNz
aW9uKzB4NTQvMHgxOTAKWyA0MDA0Ljg2NjU0NF0gID8gcGF0aF9pbml0KzB4MTljLzB4MzMwClsg
NDAwNC44NjY1NDZdICBwYXRoX29wZW5hdCsweGEwLzB4MzAwClsgNDAwNC44NjY1NDhdICA/IHB1
dG5hbWUrMHg0Yy8weDYwClsgNDAwNC44NjY1NTBdICBkb19maWxwX29wZW4rMHg5Yi8weDExMApb
IDQwMDQuODY2NTUyXSAgPyBfX2NoZWNrX29iamVjdF9zaXplKzB4YTQvMHgxYjAKWyA0MDA0Ljg2
NjU1NF0gIGRvX3N5c19vcGVuKzB4MWJhLzB4MjUwClsgNDAwNC44NjY1NTZdICA/IGRvX2ZpbHBf
b3BlbisweDUvMHgxMTAKWyA0MDA0Ljg2NjU1OF0gID8gZG9fc3lzX29wZW4rMHgxYmEvMHgyNTAK
WyA0MDA0Ljg2NjU2MF0gIF9faWEzMl9jb21wYXRfc3lzX29wZW5hdCsweDFkLzB4MjAKWyA0MDA0
Ljg2NjU2Ml0gIGRvX2Zhc3Rfc3lzY2FsbF8zMisweGIxLzB4MmMwClsgNDAwNC44NjY1NjVdICBl
bnRyeV9TWVNFTlRFUl9jb21wYXQrMHg4NC8weDk2ClsgNDAwNC44NjY1NjZdIFJJUDogMDAyMzow
eGY3Zjc5YzU5ClsgNDAwNC44NjY1NjddIENvZGU6IDg1IGQyIDc0IDAyIDg5IDBhIDViIDVkIGMz
IDhiIDA0IDI0IGMzIDhiIDBjIDI0IGMzIDhiIDFjIDI0IGMzIDhiIDNjIDI0IGMzIDkwIDkwIDkw
IDkwIDkwIDkwIDkwIDkwIDUxIDUyIDU1IDg5IGU1IDBmIDM0IGNkIDgwIDw1ZD4gNWEgNTkgYzMg
OTAgOTAgOTAgOTAgZWIgMGQgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgClsg
NDAwNC44NjY1ODldIFJTUDogMDAyYjowMDAwMDAwMGU2NWM4OGEwIEVGTEFHUzogMDAwMDAyODIg
T1JJR19SQVg6IDAwMDAwMDAwMDAwMDAxMjcKWyA0MDA0Ljg2NjU5MV0gUkFYOiBmZmZmZmZmZmZm
ZmZmZmRhIFJCWDogMDAwMDAwMDBmZmZmZmY5YyBSQ1g6IDAwMDAwMDAwZWU4NjUwZmMKWyA0MDA0
Ljg2NjU5Ml0gUkRYOiAwMDAwMDAwMDAwMDAwMDAyIFJTSTogMDAwMDAwMDAwMDAwMDAwMCBSREk6
IDAwMDAwMDAwZjdjMTEwMDAKWyA0MDA0Ljg2NjU5M10gUkJQOiAwMDAwMDAwMDAwMDAwMDAwIFIw
ODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6IDAwMDAwMDAwMDAwMDAwMDAKWyA0MDA0Ljg2NjU5NF0g
UjEwOiAwMDAwMDAwMDAwMDAwMDAwIFIxMTogMDAwMDAwMDAwMDAwMDI4MiBSMTI6IDAwMDAwMDAw
MDAwMDAwMDAKWyA0MDA0Ljg2NjU5NV0gUjEzOiAwMDAwMDAwMDAwMDAwMDAwIFIxNDogMDAwMDAw
MDAwMDAwMDAwMCBSMTU6IDAwMDAwMDAwMDAwMDAwMDAKWyA0MDA0Ljg2NjU5Nl0gTW9kdWxlcyBs
aW5rZWQgaW46IHJwY3NlY19nc3Nfa3JiNSB4ODZfcGtnX3RlbXBfdGhlcm1hbCBrdm1faW50ZWwg
a3ZtIHNuZF9oZGFfY29kZWNfaGRtaSBzbmRfaGRhX2NvZGVjX2NhMDEzMiBzbmRfaGRhX2ludGVs
IHNuZF9oZGFfY29kZWMgc25kX2hkYV9jb3JlIHNuZF9od2RlcCBpcnFieXBhc3Mgc25kX3BjbSBj
cmMzMmNfaW50ZWwgZ2hhc2hfY2xtdWxuaV9pbnRlbCBteG1fd21pIHNuZF90aW1lciBjcnlwdGQg
YWx4IHdtaSBzbmQgdmlkZW8gc291bmRjb3JlIGNvcmV0ZW1wIGVmaXZhcmZzIGRtX3plcm8gZG1f
dGhpbl9wb29sIGRtX3BlcnNpc3RlbnRfZGF0YSBkbV9iaW9fcHJpc29uIGRtX2xvZ191c2Vyc3Bh
Y2UgZG1fZmxha2V5IGRtX2RlbGF5IHZpcnRpb19wY2kgdmlydGlvX3Njc2kgdmlydGlvX2JsayB2
aXJ0aW9fY29uc29sZSB2aXJ0aW9fYmFsbG9vbiBzaGE1MTJfZ2VuZXJpYyBsaWJpc2NzaSBzY3Np
X3RyYW5zcG9ydF9pc2NzaSB0dWxpcCBjeGdiMyBjeGdiIGN4Z2I0IHZ4Z2UgYm9uZGluZyB2eGxh
biBpcDZfdWRwX3R1bm5lbCB1ZHBfdHVubmVsIG1hY3ZsYW4gdm14bmV0MyB2aXJ0aW9fbmV0IG5l
dF9mYWlsb3ZlciBmYWlsb3ZlciB2aXJ0aW9fcmluZyB2aXJ0aW8gdGczIGxpYnBoeSBza3kyIHI4
MTY5IHBjbmV0MzIgbWlpIGUxMDAwIGJueDIgYXRsMWMgZnVzZSB4ZnMgamZzIHJlaXNlcmZzIGJ0
cmZzIHpzdGRfZGVjb21wcmVzcyB6c3RkX2NvbXByZXNzIHh4aGFzaCBsaW5lYXIgcmFpZDEwIHJh
aWQxIHJhaWQwIGRtX3JhaWQgcmFpZDQ1NiBhc3luY19yYWlkNl9yZWNvdiBhc3luY19tZW1jcHkK
WyA0MDA0Ljg2NjYzNF0gIGFzeW5jX3BxIGFzeW5jX3hvciBhc3luY190eCB4b3IgcmFpZDZfcHEg
ZG1fbWlycm9yIGRtX3JlZ2lvbl9oYXNoIGRtX2xvZyBmaXJld2lyZV9jb3JlIGNyY19pdHVfdCBz
bDgxMV9oY2QgdXNiX3N0b3JhZ2UgYWljOTR4eCBsaWJzYXMgbHBmYyBxbGEyeHh4IG1lZ2FyYWlk
X3NhcyBtZWdhcmFpZF9tYm94IG1lZ2FyYWlkX21tIGFhY3JhaWQgc3g4IGhwc2EgM3dfOXh4eCAz
d194eHh4IG1wdHNhcyBzY3NpX3RyYW5zcG9ydF9zYXMgbXB0ZmMgc2NzaV90cmFuc3BvcnRfZmMg
bXB0c3BpIG1wdHNjc2loIG1wdGJhc2Ugc3ltNTNjOHh4IGluaXRpbyBhcmNtc3IgYWljN3h4eCBh
aWM3OXh4IHNjc2lfdHJhbnNwb3J0X3NwaSBzcl9tb2QgY2Ryb20gc2cgcGRjX2FkbWEgc2F0YV9p
bmljMTYyeCBzYXRhX212IGF0YV9waWl4IHNhdGFfcXN0b3Igc2F0YV92c2Mgc2F0YV91bGkgc2F0
YV9zaXMgc2F0YV9zeDQgc2F0YV9udiBzYXRhX3ZpYSBzYXRhX3N2dyBzYXRhX3NpbDI0IHNhdGFf
c2lsIHNhdGFfcHJvbWlzZSBwYXRhX3ZpYSBwYXRhX2ptaWNyb24gcGF0YV9tYXJ2ZWxsIHBhdGFf
c2lzIHBhdGFfbmV0Y2VsbCBwYXRhX3BkYzIwMnh4X29sZCBwYXRhX2F0aWl4cCBwYXRhX2FtZCBw
YXRhX2FsaSBwYXRhX2l0ODIxMyBwYXRhX3BjbWNpYSBwYXRhX3NlcnZlcndvcmtzIHBhdGFfb2xk
cGlpeCBwYXRhX2FydG9wIHBhdGFfaXQ4MjF4IHBhdGFfaHB0M3gybiBwYXRhX2hwdDN4MyBwYXRh
X2hwdDM3eCBwYXRhX2hwdDM2NiBwYXRhX2NtZDY0eCBwYXRhX3NpbDY4MCBwYXRhX3BkYzIwMjd4
IHNkX21vZCBhaGNpClsgNDAwNC44NjY2NjldICBsaWJhaGNpClsgNDAwNC44NjY2NzFdIENSMjog
MDAwMDAwMDAwMDAwMDAxOApbIDQwMDQuODY2NjczXSAtLS1bIGVuZCB0cmFjZSA5YzIyZWFkY2E5
MjM0MzA3IF0tLS0KWyA0MDA0LjkwNzMwMV0gc25kX2hkYV9pbnRlbCAwMDAwOjAwOjFmLjM6IFVu
c3RhYmxlIExQSUIgKDM1MTY4OCA+PSAxNzY0MDApOyBkaXNhYmxpbmcgTFBJQiBkZWxheSBjb3Vu
dGluZwpbIDQwMDQuOTYzMzc1XSBSSVA6IDAwMTA6c3RlYW1fY2xpZW50X2xsX29wZW4rMHgxNy8w
eDUwClsgNDAwNC45NjMzNzhdIENvZGU6IGU4IDllIGNiIGUwIGZmIDRjIDg5IGU3IGU4IGQ2IDZh
IGZmIGZmIGViIGMwIDBmIDFmIDQwIDAwIGU4IDFiIDA5IDI2IDAwIDU1IDQ4IDg5IGU1IDQxIDU0
IDUzIDQ4IDgzIGVjIDA4IDQ4IDhiIDlmIDY4IDE5IDAwIDAwIDw0OD4gOGIgN2IgMTggZTggNDAg
NmEgZmYgZmYgODUgYzAgNzUgMWUgNGMgOGQgNjMgMjggODkgNDUgZWMgNGMgODkgClsgNDAwNC45
NjM0MDRdIFJTUDogMDAxODpmZmZmYzBhODQxYTViYjE4IEVGTEFHUzogMDAwMTAyOTYKWyA0MDA0
Ljk2MzQwNV0gUkFYOiBmZmZmZmZmZmJkYmEwZDUwIFJCWDogMDAwMDAwMDAwMDAwMDAwMCBSQ1g6
IDAwMDAwMDAwMDAwMDAwMDEKWyA0MDA0Ljk2MzQwN10gUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJT
STogMDAwMDAwMDAwMDAwMDAwMCBSREk6IGZmZmY5Yzc3NzUyZWUwMDAKWyA0MDA0Ljk2MzQwOF0g
UkJQOiBmZmZmYzBhODQxYTViYjMwIFIwODogZmZmZjljNzc3YTAwMmQ4MCBSMDk6IGZmZmY5Yzc3
NmIxNjk4MDAKWyA0MDA0Ljk2MzQwOV0gUjEwOiBmZmZmOWM3Nzc5YTFkMDI1IFIxMTogMDAzNDc3
NjE3MjY0Njk2OCBSMTI6IGZmZmY5Yzc3NzUyZWZiYTgKWyA0MDA0Ljk2MzQxMF0gUjEzOiBmZmZm
OWM3NzZkMjU2ZTAwIFIxNDogZmZmZjljNzc3NGMyYjBjMCBSMTU6IGZmZmZmZmZmYmQ0MTQ3NTAK
WyA0MDA0Ljk2MzQxMl0gRlM6ICAwMDAwMDAwMDAwMDAwMDAwKDAwMDApIEdTOmZmZmY5Yzc3OWRk
MDAwMDAoMDA2Mykga25sR1M6MDAwMDAwMDBlNjVjYWI0MApbIDQwMDQuOTYzNDEzXSBDUzogIDAw
MTAgRFM6IDAwMmIgRVM6IDAwMmIgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzClsgNDAwNC45NjM0MTRd
IENSMjogMDAwMDAwMDAwMDAwMDAxOCBDUjM6IDAwMDAwMDA4NjQ2MTQwMDUgQ1I0OiAwMDAwMDAw
MDAwMzYwNmUwClsgNDAwNC45NjM0MTVdIERSMDogMDAwMDAwMDAwMDAwMDAwMCBEUjE6IDAwMDAw
MDAwMDAwMDAwMDAgRFIyOiAwMDAwMDAwMDAwMDAwMDAwClsgNDAwNC45NjM0MTZdIERSMzogMDAw
MDAwMDAwMDAwMDAwMCBEUjY6IDAwMDAwMDAwZmZmZTBmZjAgRFI3OiAwMDAwMDAwMDAwMDAwNDAw
Cgo=
--000000000000fcf645056e3c37a3--
