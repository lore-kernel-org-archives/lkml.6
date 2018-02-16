Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-296820-1518791600-5-13977242394231024439
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518791600; b=sceczl527YU+tjCTSlWDkJwLB91oJslVrqjZhsr3iHupU1J
    l+WvSwpBX2/qjYVBz85pmkFh/RlC++4Nu6aUhgp7KgCAdww7hg0IdUXHcf5gmaTj
    p1NyaeelrxXOjJ7xTreDtNwAvL+l5352iPgmnjraBno0f9dUhbn4XV/H6KNnVBq7
    3vQaNIsPpQEptZP4TAMFAV2yUHwv2RkJwFIIlqU36EGLctIeBX23FSvi9Cb5pdmY
    q/3RNt8a3BYzIzdh6CL3EvhSE9TDKuiewngxbJ9teSqZFMwKcMwU5fIL3N76Ex/1
    AshD8E10TyqGtKGWrSIcj2QnDMbO0q/hYHpfWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518791600; bh=p
    ck4Y2nCV5n9RL4xbc1mQRHHHaBNcNA1mkGWhUieovc=; b=OfhVvd0gJUazAfWzR
    44n+ek2NCJNXN4fMclrh7D7IEDLvvAnE8tkwPw7EK3A2BRqoxRWyiRS/Ak6G9S08
    C+WsBgZFuEjVVqNQ6BbeyCA+aizL5IdHwC4zitZ8Hlbfb3bf3xpoF4svI9SL37iv
    Qd8p2qDL+g1lXkw7f8Fn8mmBOcAc9DiH3XDzUMqaL6Ph8Uc8GU/QzedouOvvcgOy
    GTqkqzmk4wUJ20d0cvIlaykVP//jTPCqsDvHoHbswhudd/mjUUsaIu2P/1pKS/j1
    oelNLJageBfL1IwRWepIYOoojdGd39dQksT1KL/fGqDpvl9S65vZukKobtkWt+iI
    Wl37g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
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
Date: Fri, 16 Feb 2018 15:33:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Naveen Panwar <naveen.panwar27@gmail.com>
Subject: Re: [PATCH 2/2] Staging: netlogic: platform_net.c: introduced a
 helper function
Message-ID: <20180216143312.GA23693@kroah.com>
References: <1516178447-4303-1-git-send-email-naveen.panwar27@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1516178447-4303-1-git-send-email-naveen.panwar27@gmail.com>
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
Cc: devel@driverdev.osuosl.org, naveen@spics.info, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Jan 17, 2018 at 02:10:47PM +0530, Naveen Panwar wrote:
> In staging/netlogic/platform.c Refactoring the identical code used
> in several places for calculating the physical address of
> memory-mapped objects on the device.Put that into an inline helper
> function and use it.
> 
> Adjust the types of arguments of xlr_resource_init() - 'offset' and 'irq'
> are actually unsigned.  The values passed to those fit into 0..2G range,
> so the behaviour is unchanged, but it's more consistent that way.
> 
> Signed-off-by: Naveen Panwar <naveen.panwar27@gmail.com>
> ---
>  drivers/staging/netlogic/platform_net.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)

This patch does not apply at all :(
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
