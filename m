Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-313932-1527715367-2-14554735225496423099
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527715367; b=jCIi+QPzYxGNfWAHG+h0YagI6zpdk3PJe0X+/UDA22kLolloNs
    vokhFCfxMQo1SjtTKuKRcYqK0Jzb/nmUaWylCn98eBZJXvHzcufG19fFKRFK5son
    uwh7UDTPMhpKmhuO7zC6mwz8VXxNYz8q5uTfa+IxI8s5UKPZCX0CnclDaaaHXJbw
    iEnUrbVuqfaaPRdP/lJsaDfpCVY9oDxoke5GCgGyv/8ZNaHLMIrmB4v3IlC6WVUE
    JRG05Y/hHH3C6omB8dBiIQAy9vJhAn9g0pprttMeayfaO6Mz2Kxo150WHwXUAvHu
    6r4FLvNbQsokRq9ZM2wIyimr7p7jau6fS1Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527715367;
    bh=FZy6Dtx90RhX4hBpy9kp462fU8kJA7p3sNt3++GFmcg=; b=R2kJb1uubQDF
    x0auFM112oA6ClFUX4SY1rwzOG6JFvSUbYZYcQrOxkoWojigiDZmanNviAz3/HLh
    l1sOkFZQAPcIlBjNapiWWrDd4VhBEWHs9WWoJDz72uYeINiyaJY/fQmmwVP8zi9g
    7lDN/dU6eYxW7FDCnf65clrVxpNeRJNFxdbdlJmmNs+3y05tQSeG8690VTHpx5ni
    5gLYcW1vuYfQqXrCal8sVjJ9YXxZMlbbUONdScj41DlXAlmjFBhpx+2rW6WdwcPT
    Slb2LTZW9n6gBO9qU7EqKKLI1KhdSNsmRIIcJx3Kvyu2BOAmiKKTHGdoJ22VLnzX
    AV/y4tyEiw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=baHke8Xk
    header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=bo1Gxdp6;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=baHke8Xk
      header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=bo1Gxdp6;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLvfkuFG4FS3z5kihrGhFpOftOfP9blfwbl1aT4xnsQVS+9/pgJd200ThZG/w9zcGA2a6kucUET00MyMZhbXm1LchW/dy9m/JVFw07eNm8cmionrifue
    uC2lbAdrp1HYkWexUUQBLzDcjXcEoJT05A6CdC/xrRPRlhlSGtSpfFmgYgXmjN0p+yqohVBx9o2HBVjpTUJFkWqZuIi0rrH3DbIdqKTebGLfVecCAdB+Z3Q0
    7lqXno8ug3qqwnJbSCHFeA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=ulJD7APe8ekA:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=qTFMqrIHr72Ci2-Mk9UA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932431AbeE3VWp (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 17:22:45 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32828 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932254AbeE3VWo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 May 2018 17:22:44 -0400
X-Google-Smtp-Source: ADUXVKLXdWVOcpuR7PUzWQH3hpZlTgP7U00MKLhUvGNyJg0D+UjsqsaTBz/u88ZY7Un9ynnrw0gxyQ==
Subject: Re: [PATCH V3 3/5 selinux-next] selinux: sidtab_clone switch to use
 rwlock.
To: Peter Enderborg <peter.enderborg@sony.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <james.l.morris@oracle.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Serge E . Hallyn" <serge@hallyn.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
References: <20180530141104.28569-1-peter.enderborg@sony.com>
 <20180530141104.28569-4-peter.enderborg@sony.com>
From: J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <c41e327f-9bf8-a2f1-bf6f-326357d5ed8b@gmail.com>
Date: Wed, 30 May 2018 14:22:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180530141104.28569-4-peter.enderborg@sony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


>   
> +int sidtab_clone(struct sidtab *s, struct sidtab *d)
> +{
> +	int i, rc = 0;
If s or d are NULL (see if() below), why would we want rc, the return 
value, to be 0?  How about defaulting rc to an error value (-EINVAL)?
> +	struct sidtab_node *cur;
> +
> +	if (!s || !d)
> +		goto errout;
> +
> +	read_lock(&s->lock);
> +	for (i = 0; i < SIDTAB_SIZE; i++) {
> +		cur = s->htable[i];
> +		while (cur) {
> +			if (cur->sid > SECINITSID_NUM)
> +				rc =  sidtab_insert(d, cur->sid, &cur->context);
> +			if (rc)
> +				goto out;
> +			cur = cur->next;
> +		}
> +	}
> +out:
> +	read_unlock(&s->lock);
> +errout:
> +	return rc;
> +}
>
Thanks,
Jay
