Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3347819-1519921447-2-4680377315775077467
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519921446; b=rrERzoZ8ampIzsziEhsw2W2fpkbaLEeDMBvQa1+oSUQvogu
    7p+KEX1Nk/NCwQqYP4SHYyStlLwsNuSms6FdXXxr8/kyFuIUVBlYhuVDRWn22y91
    bV6oTxtkux4rz7nidvNbsOp1IZhos8pTANSZox3Jx1/o6c4huk3TXpS17Cz2c9N6
    9AI/RBZn7cfMK5mVxUxRY0zNzMo+Nz2M9gPWfTEpwQX1sRGoeIShJQVdsSRi8K7p
    aM4yDdE5D0r5EIgJ5UbTQzMHP2KJvKbf3BYGWVaWelYaoS2wNhjSRNVS+BN0vQhW
    x8aaDuXeG/oWpKMHq5jI0csh1+mvjfkZ4POs8Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519921446; bh=5
    nUz04gDCgBTxt77518tJ8bQt32mCvc94/m61A4N/KY=; b=HDWqVxkgNGgyR2RfP
    foiX/3zbk7XhWbcUVzdohAb4Yt3MNplEQoSFYqfzOVKgD2zSKXy03vlpZK7NKtxq
    b2hkNERu05x1S+ymKC/wxxMlAP7SyyG9lPDEo1tJQ3UTq4Nh5xp9oRja7kcsOkH1
    9d07BJyYukNlpJwjXV9ZTZuhxt4rcQYFlLFL/AMXSdf0BbYBudHEjmlBD9Fp54cP
    x6WHB0A9BOfV6BvOP4KCnQPjP0IcX0dMxzj2UI7Ua9FwYjRWgahApk6gOD49MAgK
    IcPm0OAK0bQ5q1MwisCnbewkw8/WhB5ZCa1boIqncOWGeLfZ/KtGLSHq07180ZGY
    BLylw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 1 Mar 2018 17:24:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: umesh.freelance@gmail.com
Subject: Re: [PATCH] drivers:staging: Fix alignment warnings reported by tool
Message-ID: <20180301162400.GA28738@kroah.com>
References: <1519494760-14097-1-git-send-email-umesh.freelance@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1519494760-14097-1-git-send-email-umesh.freelance@gmail.com>
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 24, 2018 at 11:22:40PM +0530, umesh.freelance@gmail.com wrote:
> From: Umesh3034 <umesh.freelance@gmail.com>
> 
> Fix alignment warnings reported by checkpatch.pl
> 
> Signed-off-by: Umesh3034 <umesh.freelance@gmail.com>

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not use your real name.  Signed-off-by: and From: has to have
  a real name associated with it.  Use whatever you sign legal documents
  with, no anonymous patches are allowed.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
