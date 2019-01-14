Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BEAC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DEA20660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="tGdSlePk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfANJVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:21:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44849 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfANJVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:21:33 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so21896527wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 01:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=EfxReVjKVM5dXB/E6hYDp5oojFLjpxGFHhqMYkv+IGg=;
        b=tGdSlePkRUH18nT+xmG0/xy5Mf6LUQFr3THYBnOZWUNs9vSivotqDq0E/KKMAXbgJs
         eaab7udsaymUmq2h8+FEJ0sXjV1lDbNsqjJ5/WDL6OaopycYeGTV5Gy6TTnip4YVi1LL
         C9sKSniIUM/+JQUb5SIonbFUmjavr6TxPoZb9E8HY7qs+v/TTTUkmg+PnKS+OYbvWjPw
         j2VdQcfuzjACb2ateijX7FqGCuSJG4m1KHNgssXkGQB0h696e8YnjC46bq87w7TpEknI
         WvgaWRTTb7yuapEh8h/l4SuBoFopD8TkKhw1MXRoDRNB8O5p7Z7UNvyG7ezGMBpsefXG
         1i0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=EfxReVjKVM5dXB/E6hYDp5oojFLjpxGFHhqMYkv+IGg=;
        b=ckzo2Wo2xsPGjfw5GOA6deLaRYtjtiGmoVozqfV4mrKrsd2lNxoAy0NzAfoVMcqhZX
         bxIpsSLcwuXRZMpe611fGZ3HMbDOfgcR1kpQjxq1T78Gyo0pIbCEXyGbDv9eVl5iKX39
         vS8P+0auaxjjHXt54vT6FIHn04DM6SEA6yXElDtNpUvTCB3oJkTXRHDpiBOqVROw6TzC
         3UFNSc3XyEMCR8CTg0+eQ+MAGrTIiY39Apq0IqjDOShIcHaU6RwVcOgt4lSnOnHWxBV0
         /GTFw3S6NDW9bw1e0noqZIce3rQGS4iHJi6CyYD6MByBba9835v2BRs3DeBw80tgO2yT
         rpDw==
X-Gm-Message-State: AJcUukehtNChkAsfRKwZyTefZ1Uogy7uKBRm9PsyDmAxWbxCKr2Qn1bM
        +Vl892rIxo1HgGkqgQSTOMQTwQ==
X-Google-Smtp-Source: ALg8bN7OohKR+B7mHHoae7kVhoNz7EQDbgkFyBNYh85KkAjo+NrvV0RozVrbxdI24l1kWJKe32tx7A==
X-Received: by 2002:adf:ef88:: with SMTP id d8mr23295886wro.163.1547457690807;
        Mon, 14 Jan 2019 01:21:30 -0800 (PST)
Received: from [74.125.133.108] ([149.199.62.131])
        by smtp.gmail.com with ESMTPSA id v6sm54414017wro.57.2019.01.14.01.21.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 01:21:29 -0800 (PST)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH 0/2] microblaze: Unify the system call scripts
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <1546441924-20262-1-git-send-email-firoz.khan@linaro.org>
 <86b91768-2a3d-eb58-c9a5-641be473f301@monstr.eu>
 <CALxhOnhxyz03xvwXXUoZ8Gk=NrgdHU5CVoEXMFh77R4saWJyPg@mail.gmail.com>
 <CALxhOnjY7Ea2FrxpwMy-ETnfGCvyc8-Ds0LR2J2Tp9CQft9N5A@mail.gmail.com>
From:   Michal Simek <monstr@monstr.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=monstr@monstr.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a734e605-3e1e-1e14-de6f-cb59cbb17291@monstr.eu>
Date:   Mon, 14 Jan 2019 10:21:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CALxhOnjY7Ea2FrxpwMy-ETnfGCvyc8-Ds0LR2J2Tp9CQft9N5A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="sfwDWT7OSH4wy7qjfPu0BCkBuHRAYje9f"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sfwDWT7OSH4wy7qjfPu0BCkBuHRAYje9f
Content-Type: multipart/mixed; boundary="pggHkskJhx44hcO1obsKlFZfDZW0lcmKP";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Deepa Dinamani <deepa.kernel@gmail.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <a734e605-3e1e-1e14-de6f-cb59cbb17291@monstr.eu>
Subject: Re: [PATCH 0/2] microblaze: Unify the system call scripts
References: <1546441924-20262-1-git-send-email-firoz.khan@linaro.org>
 <86b91768-2a3d-eb58-c9a5-641be473f301@monstr.eu>
 <CALxhOnhxyz03xvwXXUoZ8Gk=NrgdHU5CVoEXMFh77R4saWJyPg@mail.gmail.com>
 <CALxhOnjY7Ea2FrxpwMy-ETnfGCvyc8-Ds0LR2J2Tp9CQft9N5A@mail.gmail.com>
In-Reply-To: <CALxhOnjY7Ea2FrxpwMy-ETnfGCvyc8-Ds0LR2J2Tp9CQft9N5A@mail.gmail.com>

--pggHkskJhx44hcO1obsKlFZfDZW0lcmKP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14. 01. 19 9:03, Firoz Khan wrote:
> Hi Michal,
>=20
> On Thu, 3 Jan 2019 at 18:39, Firoz Khan <firoz.khan@linaro.org> wrote:
>>> Looks good. Will keep this in my queue till depending patch is applie=
d.
>>
>> Thanks for the feedback. As Geert shared few feedback while m68k revie=
w,
>> Hopefully, I may have to include those changes here also.
>=20
> FYI, I'm going to abandon this patch series (for other 9 architecture
> also) and planning to come up with asm-generic support along with\
> this one. That can be single patch series and everything can be landed
> in upstream in the same time.

ok. Thanks for letting me know.
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--pggHkskJhx44hcO1obsKlFZfDZW0lcmKP--

--sfwDWT7OSH4wy7qjfPu0BCkBuHRAYje9f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlw8VJIACgkQykllyylKDCGg4gCfb383L1CrtKZdwuQOWEBWKqGg
oDUAn3hHnqiRNbPS9LNxDL7VkHMTttjF
=cAJS
-----END PGP SIGNATURE-----

--sfwDWT7OSH4wy7qjfPu0BCkBuHRAYje9f--
