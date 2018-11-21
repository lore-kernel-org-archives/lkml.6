Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B51C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 04:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E67621104
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 04:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E67621104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeKUPb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 10:31:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:46726 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726135AbeKUPb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 10:31:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2368BAD24;
        Wed, 21 Nov 2018 04:59:05 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Joe Perches <joe@perches.com>,
        Cristian Sicilia <sicilia.cristian@gmail.com>,
        Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        David Lin <dtwlin@gmail.com>
Date:   Wed, 21 Nov 2018 15:58:53 +1100
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: Parenthesis alignment
In-Reply-To: <0d630c2b5d234eb4131b8021b345edbf080b2c52.camel@perches.com>
References: <1542569289-19899-1-git-send-email-sicilia.cristian@gmail.com> <0d630c2b5d234eb4131b8021b345edbf080b2c52.camel@perches.com>
Message-ID: <87zhu3auwi.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Sun, Nov 18 2018, Joe Perches wrote:

> On Sun, 2018-11-18 at 20:28 +0100, Cristian Sicilia wrote:
>> Some parameters are aligned with parentheses.
>> Some parentheses are opened at end of line.
>
> Given the very long identifier lengths, I wouldn't
> consider many of these appropriate.
>
> 80 column line lengths and long identifiers don't
> play well together.
>
>> diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
>
> []
>> @@ -70,7 +70,7 @@ static int gbaudio_module_enable_tx(struct gbaudio_codec_info *codec,
>>  		i2s_port = 0;	/* fixed for now */
>>  		cportid = data->connection->hd_cport_id;
>>  		ret = gb_audio_apbridgea_register_cport(data->connection,
>> -						i2s_port, cportid,
>> +							i2s_port, cportid,
>>  						AUDIO_APBRIDGEA_DIRECTION_TX);

My preferred formatting in this situation is

  		ret = gb_audio_apbridgea_register_cport(
                	data->connection,
 			i2s_port, cportid,
			AUDIO_APBRIDGEA_DIRECTION_TX);

but checkpatch doesn't like the '(' at the end of the line.
Do you know why that is?

Thanks,
NeilBrown


>
> But if you are going to do this for multiple line
> statements, please fix all the line continuations of
> the statement, not just the first.
>
>>  		if (ret) {
>>  			dev_err_ratelimited(module->dev,
>> @@ -160,7 +160,7 @@ static int gbaudio_module_disable_tx(struct gbaudio_module_info *module, int id)
>>  		i2s_port = 0;	/* fixed for now */
>>  		cportid = data->connection->hd_cport_id;
>>  		ret = gb_audio_apbridgea_unregister_cport(data->connection,
>> -						i2s_port, cportid,
>> +							  i2s_port, cportid,
>>  						AUDIO_APBRIDGEA_DIRECTION_TX);
>
> etc...

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlv05g4ACgkQOeye3VZi
gbk28Q//QuBJmGLrJsf6yTlutL+yhN0sYaHmpE6yJFwvGGajhHard+Pyz7jwsqIY
pgcwYqPwjpvdTV85zcl1jEIs0Wc72jhXtZuHMTCTF+QHMAk/Sc5OoXRZdya/Q5P6
gfre5nTNUEEEzh1oscGY+gRdJp9l8ELZkdZGAeu5WxlxpuxnloOkydOFOiXfdqBW
knIwLQeNbBiD8wdGYdiR+y3hG8FRQqRdtqL+k9OKua/Gywq/GvwplEqyGZANtJyV
Oj1d34970E3q5ODao/HaXE8NeYFTDUPFsmHh9pcFiNHclyLeh472cAoALbr9/uwu
5ri0Ekv+exTUfRaV9MRnCkZPaYVIMAiFHt9HS0QgaXkPE7qWFiWve4BmysA5yMKi
RiWUqRXL4WAVdkDJ+7S+honBofbamVYdmHV/JYNZNOLfC4TicP3X/o1KUif+khJy
MteiOs31QF5cegwb5zg15z7QKfc1ZBDROjhHNHpri4I0NoB6c3BaGKykzaG9ix8L
xYqih4xKOG46gXzRSKFEMqzKLI8N5FtLHsJOGA0AJSDLEhRW8yIwP/ObGFPiarpi
fCefqW1Y86zCdvjVo0y1HnxzaHDbGqNcX8iaDu+o742ynMbi/W3/FFr0fLQPj9cZ
4QuizyAqF6j0ZZiot1auEnkJOEstZSkIeAH5gLDVdedd2cYVl+A=
=Rz9D
-----END PGP SIGNATURE-----
--=-=-=--
