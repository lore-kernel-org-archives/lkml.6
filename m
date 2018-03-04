Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3824665-1520204272-2-5331590505069086545
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='cc', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520204271; b=o6wIoKYyATgIu+1Bum8ADyFdIe7+bUgBqIqTlG750Ilgwv9
    67FLpj2zwcilU1OjCbSnypPCDbrIml72fe5+pOiODcijN2IUlKJ6+zaxVbN6ZJvb
    SWsI7B5iJCmvDagDQKnu/t/eOyJoGpvFVkSdqV6yKmnwe2xneH4J5gaY+E7KX/Sq
    k+RWlq7aiq8IRCHyBRjCm3wkzaJBgB1mYXnm56rLR/dFQN6QkfFkl/eWDaa9K8XL
    l8k5cdn8F7Psoo/GBrFaza7a/dd/nqYiGPB5LnE+1knvSCkSnB80rJ2PJm6RVf5E
    CiCkowzg4OA46XNMmlNhy/uinEMY6kYOnjxfkxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520204271; bh=W
    cAYprdNgt4xFoxzOSNFFCM2YsCbUjNFja5AppWTC8A=; b=DVZvkiAyxE4k0mfdG
    NQqvsJEPRp3r6G1/MbJmeXTRWWizLSxx1C/v1Ny8imKskCONDkB+GBpfwcZAlUro
    6OpOVff81AAeY19wDd2V2c84lFgTZ4MGyP2w/aKAsz/liWceCDaINaWR3hgP8cIC
    PvRLhqCnHeF/ivgIT5RIQPNu7vJGk/KEyqcAGWNXhCTYWQW+pJsDwZaoCro2SMK8
    /4GU1UL92ZiY00BlLQn5grha1CajgiSRAy/k6QJHcBxkju/G+hb84y7hrWpkXZbc
    T5HgCW/+qbztMi20YKUO64a7x4aLgmvLNBqaX36f9WruibNUrW1CN/3lFYvTfGx8
    tzeCA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=bmGZLf7S x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=VaPjKtW3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tobin.cc header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=bmGZLf7S x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=VaPjKtW3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tobin.cc header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-ME-Sender: <xms:5HmcWvZyKnhKaBDZk83tt402C4m4HymwduHTvHaACAy72QiIJppzzg>
Date: Mon, 5 Mar 2018 09:57:37 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 3/5] staging: ks7010: Factor out repeated code into
 function 'ks_wlan_cap()'.
Message-ID: <20180304225737.GG18371@eros>
References: <20180301051911.1314-1-quytelda@tamalin.org>
 <20180301051911.1314-3-quytelda@tamalin.org>
 <20180301063721.GD4059@eros>
 <20180301111500.lxge4yqfyi2najt6@mwanda>
 <20180301205436.GE4059@eros>
 <20180302090503.2zgnzhy5dtolmk3n@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180302090503.2zgnzhy5dtolmk3n@mwanda>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: devel@driverdev.osuosl.org, wsa@the-dreams.de, gregkh@linuxfoundation.org,
 driverdev-devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
 Quytelda Kahja <quytelda@tamalin.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 12:05:03PM +0300, Dan Carpenter wrote:
> There are so many rules for kernel developers to deal with.  Is it worse
> to go over the 80 character limit or align the parameters properly?  Is
> it OK to start the subject with a lower case letter?  I get in trouble
> for using the wrong prefix but I'm the first person to patch a driver so
> how on earth am I supposed to read into your @#$R@#$@#$@#$@ mind to see
> what prefix you are going to want?
> 
> The imperitive thing is a good suggestion for people to think about but
> it's not something that you should suggest to other people out of the
> blue for no reason.  I've seen people do it for OPW and I'm like, "Eh...
> I guess in that case maybe the intern will have to deal with some super
> anal maintainer so they should know all the rules".  But generally,
> unless the person asked you to tutor them about every single unpleasant
> thing/maintainer they might have to deal then just let it be.  Otherwise
> you risk becoming that unpleasant thing they have to deal with.
> 
> Don't lose track of the bigger picture which is "Can you understand the
> changelog?"  There is no such thing as a perfect patch.  This patch has
> a style violation which I overlooked because it just doesn't matter.
> 
> It's discouraging to be nagged at.
> 
> regards,
> dan carpenter

No worries Dan, thanks for pointing this out.  I actually don't enjoy
reviewing staging patches.  I guessed no one really likes reviewing them
but I feel that we should all give back a little and since I don't have
all that much to give I figured reviewing staging patches was a good way
to do something that others probably don't like doing.  I'd like to be
able to do the reviews in a way that is encouraging to new devs but like
most I only have my own likes/dislikes to go on.  I liked having every
detail of my first X patches picked apart because it meant I was
confident then to go on and try to do patches outside of staging -
others may vary and I definitely agree with you that no one likes to be
nagged so it's a fine line.  If you have any suggestions for me as to
how to be more useful in reviewing staging patches please do share
them.  So far I only have one clue as to how to go about it and that was
this from Greg KH 'Just be polite'.  There certainly is a lot to learn
getting started with kernel work but for me anyways staging is doing
really well at smoothing the process and that is mainly thanks to Greg
and yourself in doing the reviews.  If I'm totally wrong and you two
really love doing it then I will happily bow out and not touch another
staging patch (please say so if this is the case).  If I can help to
carry the load then I'm happy to do so because you two helped me a lot.
Please continue to pick me up if I do wrongs - I'm super happy when you
do because then I've got a chance of doing it right next time :)


thanks,
Tobin.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
