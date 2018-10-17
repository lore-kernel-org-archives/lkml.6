Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72FDECDE3D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DBC213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20150623.gappssmtp.com header.i=@dilger-ca.20150623.gappssmtp.com header.b="dBgwcSCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82DBC213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbeJRH1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 03:27:03 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38690 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbeJRH1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 03:27:03 -0400
Received: by mail-io1-f68.google.com with SMTP id n5-v6so19907711ioh.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 16:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=nIDM1ezht43if4Qvm4esFDRf3DQR2HGEF5t1fVy0Em4=;
        b=dBgwcSCQL88AK2zJQkQkXp1xdguHzXy5KnTK2URfw/cf2cMa7ty9VBLJcTl7j5cMWl
         RejXklV3cEg/Z7kRr0q48HXVzHGxK5QcVUI0YKScVbMisg72c4YwFLl1Gu+srtPLBW5m
         QicM0vtWkvNnExz0zWyrqGQ2D7A7Pw3NgzHxULe4xZQhQshhASIGIWLGtN/tB7g1YxCv
         bRHzvPWdijkblUOQXhkIBNzP0vKYkmokY2SDzd1UJbLtjvKBEa84wPWcqrwOy0wUs2AT
         yO0C2dZW3l5LLhzMFmva749waQf7rQMEBrCxPMxeYmEngwL2rFppuwxjpZeCQHWyrStz
         LsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=nIDM1ezht43if4Qvm4esFDRf3DQR2HGEF5t1fVy0Em4=;
        b=bAJ8gE3mMMjpsoIWsGpjYJrgpT4mvuOgvPXNtTxLjg8fRWn9u59XkgsxOjPYstgSEF
         5g2ada8FQcj0+dIIKsnJ1ikbTRdjvMOO2caGm4GvGEVfh0frW/suB1GYes9yXKboL999
         dXaB5e1xmnu/bJ3sNG7HhcPnK+1hUDRt1ijt3kjOvGrVKp28+ZJm20W6Zd9/FdsUErV7
         aFxIRx/A6kn1Kv6spYuVyg0ltDA0V6wS7e+Xyium6kIoACPEZHeHLQl8kbohum35Gh+q
         yMMTONR35TbEkp1Twtx2LuvH3GttubWA/icaXMlnvnU98i1k+IWQZRplFeGmeE6QNqTM
         UbfA==
X-Gm-Message-State: ABuFfojAUTLIJYqGcSnSPxQGzzUOQK4LK5UGIV6b8yKAiq8nabjp+KVb
        2p1A7aiuoz4B6fSI87ovADM0Vw==
X-Google-Smtp-Source: ACcGV62TliuarjSYAUscDEsQwDWEoHvEaCga3gimOHQRgw5+PswCVbjRTzRBHk57pxSX274P2kOXog==
X-Received: by 2002:a6b:3784:: with SMTP id e126-v6mr17065764ioa.206.1539818940195;
        Wed, 17 Oct 2018 16:29:00 -0700 (PDT)
Received: from cabot-100.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id e68-v6sm1686956ita.5.2018.10.17.16.28.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 16:28:59 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <EA9B5AA4-DA21-4B1D-9E89-8C9F16EB8986@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C878ED81-577A-481B-B30C-166BF18D6A8B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: direct return when jinode allocate failed
Date:   Wed, 17 Oct 2018 17:28:55 -0600
In-Reply-To: <201810171026448096961@zte.com.cn>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, fishland@aliyun.com,
        wang.yi59@zte.com.cn,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     liu.song11@zte.com.cn
References: <20181016145526.3288-1-fishland@aliyun.com,20181016190840.GF24131@thunk.org>
 <201810171026448096961@zte.com.cn>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_C878ED81-577A-481B-B30C-166BF18D6A8B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Oct 16, 2018, at 8:26 PM, liu.song11@zte.com.cn wrote:
>=20
>> On Tue, Oct 16, 2018 at 10:55:26PM +0800, fishland wrote:
>>> The jinode does not need protected by *i_lock*, we can return
>>> directly if memory allocation fails.
>>>=20
>>=20
>> I don't see anything wrong with this patch, but at the same time, I'm
>> not sure I see the benefit, either.  Checking for the allocation
>> failure is cheap, and moving it out spinlock doesn't buy much; not to
>> mention that the allocation failure is going to be highly uncommon.
>>=20
>> What inspired this commit?
>>=20
>> - Ted
>=20
> Hi, Ted
> I found this during code reading. All code logic is very smooth, when
> reading here, need to spin_unlock before "return -ENOMEM", which I
> feel this could more close to the allocate. I refer to other =
processing
> logic for this situation in "inode.c", found that they all return =
immediately
> after memory application failed. I agree with you that the benefit of =
this
> patch is almost none, however it can slightly improve the code in rare =
case.

Looking at the patch there are two effects that it has:
- optimize a very rare case where there is an allocation failure before =
locking
- return an unnecessary error if "ei->jinode" is allocated before =
locking

I don't think it is worthwhile to optimize this case, since allocation =
failures
will have a serious impact on the application, and I'd rather avoid the =
rare
case where we don't return an unnecessary error than make the error case =
faster.

Cheers, Andreas

>=20
>>> Signed-off-by: Liu Song <liu.song11@zte.com.cn>
>>> Reviewed-by: Wang Yi <wang.yi59@zte.com.cn>
>>> ---
>>> fs/ext4/inode.c | 7 +++----
>>> 1 file changed, 3 insertions(+), 4 deletions(-)
>>>=20
>>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>>> index d767e993591d..67ba6f062de5 100644
>>> --- a/fs/ext4/inode.c
>>> +++ b/fs/ext4/inode.c
>>> @@ -4384,12 +4384,11 @@ int ext4_inode_attach_jinode(struct inode =
*inode)
>>>         return 0;
>>>=20
>>>  	jinode =3D jbd2_alloc_inode(GFP_KERNEL);
>>> +	if (!jinode)
>>> +	return -ENOMEM;
>>> +
>>>  	spin_lock(&inode->i_lock);
>>>  	if (!ei->jinode) {
>>> -		if (!jinode) {
>>> -			spin_unlock(&inode->i_lock);
>>> -			return -ENOMEM;
>>> -		}
>>>  		ei->jinode =3D jinode;
>>>  		jbd2_journal_init_jbd_inode(ei->jinode, inode);
>>>  		jinode =3D NULL;
>>> --
>>> 2.17.1


Cheers, Andreas






--Apple-Mail=_C878ED81-577A-481B-B30C-166BF18D6A8B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlvHxbgACgkQcqXauRfM
H+CCcA/+OMy3TvcdQXystp7YhvSJYGSfFRnvWBSczl3DvC5KzEbxk6owU8I1ZgLW
xy39xc/gZur31Qsqquj7R+SHJshQ06xOd2Uzv7YfjIuKdYCoQNx89xstOqyNRjER
u15kqBFHj5yadbHOslcr+qd1nslzZUg601c/ef6T0jxHcMjFD8lUBnQEktbTTOBx
1CiCNpp03/tQFElX8ZKOVsMs2toTdNWNEIC8PvWqfpgDaFeT4+Sr3z5NfZQ17u0Q
UGNlN3FrtKEch2nMBgz2z38TxdEVJrr/XAOZ3X6GEbvwVhgHNQHLQwRyz0RC9vQJ
bl/3D/8rnOSu2mHL7cUzbquCWFL2w58IW9XqraVFDUp7U4nS0Qg4SatT3mxKFVfI
clheMhNxylzVIMx9+BD/f40B+68zapPEMJSKzKzxpGCClzV7aJ+oi7u4V4RUkrcc
zaNR0X7C4h2flTX5MATfNX4sCoT4luaoAeytlsLfugCLCc5un4+ZnBUDO4DOsOUX
U8lZHJ5TWCWIVDg6YyX66uQA9g1YtqeT10c489ho83vbxt6FimXtEcEz43HVRit5
trI/Rzj8ZfaP5GS5puwOB6+qZmQer7YFhMamlp0Zd8T2hqabMHvq/cOlwglcArRw
+5uAgdA+SvGe1ykBDKfpGO+lBhA8YcA/BUV4l1nST6H+otysn58=
=hWNJ
-----END PGP SIGNATURE-----

--Apple-Mail=_C878ED81-577A-481B-B30C-166BF18D6A8B--
