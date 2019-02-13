Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA16BC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 04:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F3321905
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 04:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXOGdz7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732027AbfBMENQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 23:13:16 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45492 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730355AbfBMENQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 23:13:16 -0500
Received: by mail-pl1-f196.google.com with SMTP id r14so524328pls.12;
        Tue, 12 Feb 2019 20:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=fr0OsBHt45cqW3qulLklim0oX+0Jlu5x/93QQ00dLn8=;
        b=HXOGdz7PRdbY1JJX4Snu6sXuz8fo1zuKzrm7fW01YsrzmrjJKw/5mGNEN+FqriKuwH
         GMOFAKaeYiQZgut0oHLpiX/Lvljt5leXqiUNCtKxYX0KHvc4mNhG7mFaMA6e4n7bxu+5
         zzIQc6PwxKn+FQsR6Ol6/aR/L2zllvz+t9fLsCRdJQNMXCqRpQagBsZm8K8Ts1TjRgb2
         ClEgHoyGRXxAcoQfpYES4tz9j1j1kYf210qUeeVR6K86LzgQTsE8MiMJNs/AGr2a+9DJ
         urvKq6nmHamLABPhuxamUw8fOBkt0ux+TRbLssV8WHzYKhHPx5hivn3ORi5TrAA7oqNb
         xj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=fr0OsBHt45cqW3qulLklim0oX+0Jlu5x/93QQ00dLn8=;
        b=YPpwi8HDVJu0Kg49upGc39a0iint3zU1QsetfYgbFyX6Ci/+me5I+fJoNS2PLPa1mt
         RAz9yyPYlnL2ntuoLu8Q3F0LA2tUHJw+mRbRlCp2lylspl/ILxOpa05YGJzKE6uwg9ur
         Bd5/p2vCLqCuJwgD4CtiB/3YifSWlTJSKXrvsLlH4P1wreavjd7VB/1XGYd0Ko9YcFrr
         YC+yvX+viUKi86g39/jR9NyO3w5Y4h54RgLney8wa6JZ0AjL6927pRBNU0bd8GKCIES9
         VuDJushAXekoBgZznC9pMZFYy9hhlFvWsggjt47AqMmlAYpU72lQUXRtXBZd3+OxgoSZ
         GxbQ==
X-Gm-Message-State: AHQUAuacvMyV5KuaCv47JLd7jayxu/y5HsdZJPoqpGttcKg68HMxHCup
        afOl63Xigz+LaVm6Spk6yXo=
X-Google-Smtp-Source: AHgI3IYKYFktQvR8pvQDZ+iGMAceyvLtDRorNrN/iil6Y/F9h5Ar+ZEeXM/xFtY+rrirIZgotemUEw==
X-Received: by 2002:a17:902:aa44:: with SMTP id c4mr7577932plr.91.1550031195360;
        Tue, 12 Feb 2019 20:13:15 -0800 (PST)
Received: from mdr-mbp.hsd1.ca.comcast.net (c-73-189-12-233.hsd1.ca.comcast.net. [73.189.12.233])
        by smtp.gmail.com with ESMTPSA id b24sm21540635pfe.136.2019.02.12.20.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 20:13:14 -0800 (PST)
From:   Mark D Rustad <mrustad@gmail.com>
Message-Id: <B6967E84-6DCE-4390-B2D1-E3B4A0146DD6@gmail.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_7C06730C-895B-4916-87E2-2B4B7DED7177";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: Linux 4.4.174
Date:   Tue, 12 Feb 2019 20:13:11 -0800
In-Reply-To: <20190209081301.GB30034@kroah.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>
To:     Greg KH <gregkh@linuxfoundation.org>
References: <20190208105422.GA32328@kroah.com>
 <20190208105431.GB32328@kroah.com>
 <870EE9C6-3748-498C-B6E8-33724168C605@gmail.com>
 <20190209081301.GB30034@kroah.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_7C06730C-895B-4916-87E2-2B4B7DED7177
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii;
	delsp=yes;
	format=flowed

On Feb 9, 2019, at 12:13 AM, Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Feb 08, 2019 at 08:44:32PM -0800, Mark D Rustad wrote:
>> On Feb 8, 2019, at 2:54 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>>> diff --git a/Documentation/networking/ip-sysctl.txt
>>> b/Documentation/networking/ip-sysctl.txt
>>> index 2ea4c45cf1c8..7c229f59016f 100644
>>> --- a/Documentation/networking/ip-sysctl.txt
>>> +++ b/Documentation/networking/ip-sysctl.txt
>>> @@ -112,14 +112,11 @@ min_adv_mss - INTEGER
>>>
>>>  IP Fragmentation:
>>>
>>> -ipfrag_high_thresh - INTEGER
>>> -	Maximum memory used to reassemble IP fragments. When
>>> -	ipfrag_high_thresh bytes of memory is allocated for this purpose,
>>> -	the fragment handler will toss packets until ipfrag_low_thresh
>>> -	is reached. This also serves as a maximum limit to namespaces
>>> -	different from the initial one.
>>> -
>>> -ipfrag_low_thresh - INTEGER
>>> +ipfrag_high_thresh - LONG INTEGER
>>> +	Maximum memory used to reassemble IP fragments.
>>> +
>>> +ipfrag_low_thresh - LONG INTEGER
>>> +	(Obsolete since linux-4.17)
>>
>> It seems very strange to say that it is obsolete since 4.17 in a 4.4  
>> kernel.
>
> 4.17 is a point in time :)

Of course I understand, but some random non-kernel-developer tuning a  
kernel may be pretty puzzled. I don't know right off the top something  
brief that would be more generally meaningful, but maybe someone might.  
What does obsolete mean in this context? It exists but does nothing? It  
exists and does something but will eventually go away?

--
Mark Rustad, MRustad@gmail.com

--Apple-Mail=_7C06730C-895B-4916-87E2-2B4B7DED7177
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEE6ug8b0Wg+ULmnksNPA7/547j7m4FAlxjmVgACgkQPA7/547j
7m5Lfg//XSpGRc1i7m43aZSte4yVA64c0yoAQ2Oj35kT4sxwLBIvIvWThpuq+JoM
/jTKqpuyHnREKKo74WA2XcJWnblopZieF8+d09df0599cuH0LxIKHAFf3k8uL3rB
dSu95H+qrrQ0htlf4UbJ0SXcxKvhsKuHx3qTDx3oFExBZOnesT94wHvLmPY804Um
kcaqoIWkmgdHo3KvOORX68rqBM+/AXgPL9drlbTBhkdl4+IE/i7lLVRv/JVvle6S
+4zk/9g8JMRXSWXrDaV307J+zJPwquWrC92g41UrdBxqUpkyLgJ0I9sBUWEkfsk4
3eXUAATVdNeRj0dCKGddT9YTQHuYdEHgELBI/xbCTPCQOQSyxrZLoHzGKG9Yh7GH
b7kPE6k0MY8D3Mh8rnN1pIARII96AB0+8SvG2LXO+bo9ufufxIzhvNowWhlnW/2j
ypHLtYYjs2MHFlQtQoLcEYglxEe7tnh6V4ndQgiv+fFT4t/j+8iKF3bIp87+2yS+
AL3k+1JBh7iCRFaqipQ27q63qSHjYX0zDxp9gkO4/fNWVQIla2ESC+tU68RYhOQe
DXp/VEHwoq8Hsh8nrkEfvUMtoWvoTXOsj5Kw3qx6KPB9cxqzzmONNfpQ7Vo7yQUB
mYecqogKHIVv6SP4ayr4Cr8K7ruaZoLzZSv5xPL7LjD5F/tjQ1A=
=4pVf
-----END PGP SIGNATURE-----

--Apple-Mail=_7C06730C-895B-4916-87E2-2B4B7DED7177--
