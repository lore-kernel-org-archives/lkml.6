Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0851FC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 19:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A711623FEB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 19:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A711623FEB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754080AbeGET1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 15:27:22 -0400
Received: from anholt.net ([50.246.234.109]:33250 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753950AbeGET1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 15:27:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id D22C910A1860;
        Thu,  5 Jul 2018 12:27:20 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id R2bjtIewpHIG; Thu,  5 Jul 2018 12:27:19 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id A18E210A0F6A;
        Thu,  5 Jul 2018 12:27:19 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 219FD2FE2D94; Thu,  5 Jul 2018 12:27:19 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fixup! firmware: raspberrypi: Remove VLA usage
In-Reply-To: <CAGXu5jLqkdSYd4MWPm9v49U+6FvgfMLtG1Vz3SUBR999vHshHQ@mail.gmail.com>
References: <20180629184449.GA37304@beast> <20180702194505.28355-1-eric@anholt.net> <CAGXu5jLqkdSYd4MWPm9v49U+6FvgfMLtG1Vz3SUBR999vHshHQ@mail.gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Thu, 05 Jul 2018 12:27:17 -0700
Message-ID: <87o9fltre2.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Kees Cook <keescook@chromium.org> writes:

> On Mon, Jul 2, 2018 at 12:45 PM, Eric Anholt <eric@anholt.net> wrote:
>> Kees - with this fix to your patch, the kernel boots again (otherwise,
>> the FW would try to parse the uninitialized bits of stack and throw
>> errors).  If you're good with me squashing this in, I'll do so and
>> send it to -next.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>  drivers/firmware/raspberrypi.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
>> index b80f15214b73..a200a2174611 100644
>> --- a/drivers/firmware/raspberrypi.c
>> +++ b/drivers/firmware/raspberrypi.c
>> @@ -162,7 +162,7 @@ int rpi_firmware_property(struct rpi_firmware *fw,
>>         memcpy(data + sizeof(struct rpi_firmware_property_tag_header),
>>                tag_data, buf_size);
>>
>> -       ret = rpi_firmware_property_list(fw, &data, sizeof(data));
>> +       ret = rpi_firmware_property_list(fw, &data, buf_size + sizeof(*header));
>>         memcpy(tag_data,
>>                data + sizeof(struct rpi_firmware_property_tag_header),
>>                buf_size);
>
> Eek! Yes, thank you. Yeah, please feel free to squash. Thanks for testing!

Squashed and sent the PR.  Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAls+cRUACgkQtdYpNtH8
nuhZexAAh2pEdZQoaCzEOKe9NalH7zNomyxnCuvf7JjEPumlywm0tnTFR5uYoaCb
18AtPlnbdrZM89z74gdfhEhQrP/89dWf5WGVp5haSKAbSSfUInFbwgkvWQJkNJ7S
gO3E/GxNRPlW0KKsc80sg+xk2DVaw2n+ZdYkwAYbnq/5StvOMsMPuUnERc5jwRtA
gMXZmU95XdLxRzlgfoh94U7OFyASnCs0R0WRg+AwhhtuUB/OC7IQ7vY8BYmE92do
o1IFzriLO2caVsZxZix3HFblBK+Hy4BpaugbpuIFyt1UnI/LTrhE+Gogd5XXEkTk
1FvtESGD6YXBmOrIQ97E5W8phktX68cVaxcx4fljLhQCAypNfFLFd1bnSIVad1td
Iz1sOMhLlgXG3aPBWSRTjslN4697Rl+hhhD60M5SsYbhCP3jIoIWNikhg8grKW/L
Am6NoXPDmB93SgBJZ1V/s9vOZl5Mlk/r4VxSZxexPde+l3eD1wYhgfQHpkDjglQH
p4HkrpZJbH9btf3hWAxAcGpoqBs+//b7HoaP03iicDQGhlzavbZk3kmUBxBRojQZ
y2PAm0nY0j2YPBXeNEPuzSgUPxr1ft9rGsWbDKm2wMeDNpNn+SIIESZw4ZjIiE5P
kxSb2/kPOYloAnEfi9v/9QbU5+e484RGK5Cm3hF25dBTTSAvX8c=
=U3xL
-----END PGP SIGNATURE-----
--=-=-=--
