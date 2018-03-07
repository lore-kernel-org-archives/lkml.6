Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1928353-1520389018-2-1575582157509667375
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520389018; b=GDYKyO3gOrjI3KrLlgthoWHHY59w196wiVHQ1G47RHvYXni
    S4Df4B3NNhqaNQjzbUfZhwGxbyor6PbKDy72UGHA196P6OrVzXUheDXMoBDIQf5P
    IeFlV1aGpK7fboIzhtl2JezcLJMQy1Qi0nKWGa1K84fOJOELSbZhInrou0ZvoiDG
    yiqsWzhlDPTWshIIp8qY6ICmhkQJxSxixQp2wXVmeYc6XarqKRRoeC0KpXsCpthu
    YK/FLr5rl+vFO7HDTe1CJS+1mEXK7Sjs5/a19b0TzhxXPDtC08B0BpjAQILwGo19
    07RXPfiCAx/1Uxt3jQVCZhE4VRK5mTvSqrlIDyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520389018; bh=1tdATK8GBN4e+5G+WUT++O5zMf+1UVQR6642V5hgqSc=; b=M
    Cl9WRvoV/gsm2PQaXtxCfMQf5Xuz5dZ4QEhfYX5vzhST+yFZU4uSg+zy/ck5hk9B
    gS3RaOdNkBuA5rxmfnn/rDKIcmUvgdG/b1/8V0IQ+S/nAe/AlyA32iIpg4ab+YyF
    m+xklT3U+QfSCVgS1Y5b8SX8OpkgQfrfkXbgzNS6jJlycKjc0aVoM59tZtIM88a8
    9z5JSX2ls1ewGfQYKxxPpvofi7tZHYZuig90t+si9rvecr/QB4XfOS3YUSPX4U9i
    f5xNHQbGh6l/V+LqAbQIIzcKnpcVzHHULkBivW4rkvrzAhAvEwnJwLgnyzHTOB5H
    HeUr38Yh1FZ+QZs78weqA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753957AbeCGCQz (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 21:16:55 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:38329 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753940AbeCGCQy (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Mar 2018 21:16:54 -0500
Message-ID: <1520389011.23626.24.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 06/34] sget(): handle failures of register_shrinker()
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: stable@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date: Wed, 07 Mar 2018 02:16:51 +0000
In-Reply-To: <20180302084436.414587775@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
         <20180302084436.414587775@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-03-02 at 09:51 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> 
> [ Upstream commit 9ee332d99e4d5a97548943b81c54668450ce641b ]
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  fs/super.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -497,7 +497,11 @@ retry:
>  	hlist_add_head(&s->s_instances, &type->fs_supers);
>  	spin_unlock(&sb_lock);
>  	get_filesystem(type);
> -	register_shrinker(&s->s_shrink);
> +	err = register_shrinker(&s->s_shrink);
> +	if (err) {
> +		deactivate_locked_super(s);

But deactivate_locked_super() will call unregister_shrinker(), which
doesn't look safe if register_shrinker() failed.

Ben.

> +		s = ERR_PTR(err);
> +	}
>  	return s;
>  }
>  
> 
> 
> 
-- 
Ben Hutchings
Software Developer, Codethink Ltd.
