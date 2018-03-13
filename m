Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1629513-1520899468-2-11070711706177146606
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520899468; b=YxsP3hTi5WQqHU+efd/KtT57iv/jzXH7VUqo3h+JK/1Bctf
    jWtzQTnQ0aCQOm+WC/XvkHEqqM4xShgRo7V+cD7+YyOaFemNOwrfa7MzMz9IoRhb
    RprhNOqHnz61iUpgYxviqlV32W1EhEPcCqFvVC48B9QTNy4IhYjQ26CTa7VugHXZ
    8ReIjqAGNrVE3G594KUSibPxbTeRg5IhNWUI3xmsVsMZDwL6tyRqiHgSMSs9ikMA
    REXIx16EPJowyr+2/NMCBXdKrrOqEi35ScmigSeS67muPj21yUHh3kc4VyP9/BIx
    eraeMJRq521SatimxqL5dIhnnk6mqjedirLvuvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520899468; bh=fy+TYzYULN12AVWgunW0/D1dfGfVklnZM28osw1jl4c=; b=O
    HG+LE9CxfbYtnoA1y/Kk2VGMq0SXxCnatRjl1aO6ewS0W/9o5cKJO+pH+dugvIDN
    ysl/v5D9IBCr/FinkeCXe3tJ+Jx9LleDPJMtQbuTIJn70nfRkpFnNTl/oD4r4LSN
    LBEZVyoIGVyM85RuP9evD2w6lXZossbycNsOBQVBDR+4zTmXAbdOYmxUY9BRKjAh
    Qd0T/gKH/bwvAXzFJwxFnhoOGxoob1bqnQ3QhYib1G937QYxJHLJ46dcFNy3frJX
    qiFNvV+zsGT21jgDRyLkFIT5smty/aWsRXf2q/gQWwCdY/iRcxbxPUjILS5pTcvN
    i6fEBUPdK0vOaYiGG6vCA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
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
        id S932196AbeCMAEZ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 20:04:25 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:56736 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751358AbeCMAEZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Mar 2018 20:04:25 -0400
Message-ID: <1520899459.23626.87.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 24/36] netlink: ensure to loop over all netns in
 genlmsg_multicast_allns()
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date: Tue, 13 Mar 2018 00:04:19 +0000
In-Reply-To: <20180310001808.681346858@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
         <20180310001808.681346858@linuxfoundation.org>
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

On Fri, 2018-03-09 at 16:18 -0800, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> 
> 
> [ Upstream commit cb9f7a9a5c96a773bbc9c70660dc600cfff82f82 ]
[...] 
> -	return nlmsg_multicast(prev->genl_sock, skb, portid, group, flags);
> +	err = nlmsg_multicast(prev->genl_sock, skb, portid, group, flags);
> +	if (!err)
> +		delivered = true;
> +	else if (err != -ESRCH)
> +		goto error;

This call to nlmsg_multicast() consumes skb rather than a clone, so we
must not free it again here.

Ben.

> +	return delivered ? 0 : -ESRCH;
>   error:
>  	kfree_skb(skb);
>  	return err;
> 
> 
> 
-- 
Ben Hutchings
Software Developer, Codethink Ltd.
