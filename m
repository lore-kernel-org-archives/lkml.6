Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-727864-1520105266-2-14239517585905831094
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520105266; b=bi+OeNdHWQySNz4RbplKRgVmYx3nGlSuKY97yFu09oDagxD
    SccEB2KkEnuZOD/kmFqXuFhJeXMGCmTt+ki0eL31nFBpK/EVZ5eBUhs08oSXZ/KM
    3f947lazd1G3ozbED+PzwBa8G0ZtCPQf3PwbofOGRYVedDdBtrLa+URc6E2K0S5Z
    waLnKAYjr/ecJRGE0/FzAawYrSPxFaetmVMmbBL943gf8IxLKcojpDGBmwFWXrJa
    QDj7qQFa97U+iYMKB1bRpPwqWu6F8tAVbFMB/f4NJD18l629A+xLS9Z7DZX3F8hg
    9EcNJYGDopjXVF74nuJnMRKGJ315BlUwyZUDESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520105266; bh=Y
    a2Bgv57NGEPqY8uwepP84pr43U6TTlO8nQ11i46DmY=; b=m/sYCDdfbFu1v1lh4
    Kwduz3QgrPYtPdP+ZQfgckZ632kGNKE84lXDMzUuzyRmIXDtJWepQ2u3kD5egT9z
    7I+yN1yBfmIoG2PmlXdzcLDdQ2lhjton1DKLd5X3rq744RA7MFNSCzWC7GqxQfLL
    2b+EzdC08EH0OuKn+aP6531+I69aFjHBo8YSMyojLupbtzm7rjGpQIf+4ZhZJJGY
    7ts+dOtPuh6KJqw8CUVLvb9/SRjEDERuscQz+Yq9ceLgPKJsFK4Lfm32tsbQEqWI
    7nvETyPgLcyKkwIB995j9FxBNeXBfAG6GkN5mrj7RJ1Pl636nh6/NOKW6G/wet3/
    Rr1DA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sat, 3 Mar 2018 20:27:36 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Kohli, Gaurav" <gkohli@codeaurora.org>
Subject: Re: Query:Regarding object poison overwritten in binder_transaction
Message-ID: <20180303192736.GA22510@kroah.com>
References: <4d2b6014-ea76-b489-fdde-2e058e2fac4d@codeaurora.org>
 <760538e9-dd50-6cd3-1268-bb535eb363d0@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <760538e9-dd50-6cd3-1268-bb535eb363d0@codeaurora.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org,
 Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
 Riley Andrews <riandrews@android.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 03, 2018 at 08:22:35PM +0530, Kohli, Gaurav wrote:
> HI ,
> 
> Is there any known issue of slab poisoning in binder_transaction variable on kernel 4.9,

If you are using binder in an Android device with 4.9, please use the
version in the android-common tree, as it has all of the newer features
backported properly there.  You will need that for newer Android systems
(like Android O and newer) anyway, so please try that tree.  If you
still have problems there, please file a bug in AOSP.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
