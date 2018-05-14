Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1065765-1526314742-2-15370541180049754639
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526314741; b=KYeFkZqZQ67XJk3a4UZWOiuDPcK2XG1sh1jQZxlEkLRhvQ6byU
    00Fpc+pcRbEAQJq7KstEuNjSzAyrxvAkubLsOItmTdvrCRfKiHQrEde7AUWUD9V2
    +XelctUeLoX/K5Gr4gANYeBTQie1qR2I1Nnwbj19faTOGZKVR1q0QM3ZqZ+XtIUI
    l21VT7RpVxKzIcuHfrdGoyNt+F45z/u6DBnNy78vo3+rl/qBvFez/vKJerVkr7Xj
    q6IZIv3U6bhzMV3IVqAHWtkxcPV1Wfa/qT+pnpYQcvpxU0Tc1zKypD51U2v0UNFn
    ufWNDOELbeWbQnxWSSy9/FPJH0JeViP/PaBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526314741;
    bh=YPXxhTmNGl1lnJhgkp6yG2TfzjULFW2Ym8WABfdffS0=; b=Ih5xYQV/xhB9
    Qzs3dm7rJP/QbXlriy/AyyC7LIKdmKm4NBxGo7NMEwJpiusq7s3y4OrD4O/mjIZj
    FTiAjAugQ+Y46uSsijqmPD5lVE8aYmycC2QJz4HgvIuhsH9mKKd31vknjVsPiZJ8
    yrlrX68iOTdwkvYZLc3UP3jPkzN5N7xfYtPh8DmZKAToshAQTmdcJzRTZmLH/i3M
    Xr8Tx2yk/IZeYWa/cdM1lKuH6EEvaQCXyuDKP3eUtaYoHyVy89SjBO+4ZG8QD1aV
    y0n2CZaNzJprqzbtMpnqYwP4r/zMPofuAX62Ym8XJb4iBNX3mPJzoBw+RjuNMd0D
    6UzY+3k5eg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=codethink.co.uk header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=codethink.co.uk header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMZdHTjvX3RdH0YR1v9Gf3FlGimU5mA7h+D5jYihy+ycpzZLYmGac+SvbmVUtsuscsiEI0Db8RC/d3QX3cNZGiXErZRnQuWpHvmEUiK01NPkSPeqlWJJ
    LnJoOn/OzEfT/az7x/XruJsxm4mD7HOTkiudAOZ4erdk2VfoTxosO5IJIG6xGpDV/lR6lNt6AwTROqx0Y1ZFWONx4baJ5rxsekeZj6tbWGsN8NwVbx8XpngG
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=fe96YdYo3bmXweJLhvwA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752720AbeENQS7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 12:18:59 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:33715 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752717AbeENQS7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 May 2018 12:18:59 -0400
Message-ID: <1526314736.9159.13.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 24/72] audit: add tty field to LOGIN event
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Date: Mon, 14 May 2018 17:18:56 +0100
In-Reply-To: <20180406084307.173351538@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
         <20180406084307.173351538@linuxfoundation.org>
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

On Fri, 2018-04-06 at 15:23 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Richard Guy Briggs <rgb@redhat.com>
> 
> commit db0a6fb5d97afe01fd9c47d37c6daa82d4d4001d upstream.
[...]
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1976,6 +1976,7 @@ static void audit_log_set_loginuid(kuid_
>  {
>  	struct audit_buffer *ab;
>  	uid_t uid, oldloginuid, loginuid;
> +	struct tty_struct *tty;
>  
>  	if (!audit_enabled)
>  		return;
> @@ -1983,14 +1984,17 @@ static void audit_log_set_loginuid(kuid_
>  	uid = from_kuid(&init_user_ns, task_uid(current));
>  	oldloginuid = from_kuid(&init_user_ns, koldloginuid);
>  	loginuid = from_kuid(&init_user_ns, kloginuid),
> +	tty = audit_get_tty(current);
>  
>  	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_LOGIN);
>  	if (!ab)
>  		return;

This error path leaks the tty ref.  Fixed upstream by:

commit 76a658c20efd541a62838d9ff68ce94170d7a549
Author: Richard Guy Briggs <rgb@redhat.com>
Date:   Tue Jun 28 12:06:58 2016 -0400

    audit: move calcs after alloc and check when logging set loginuid

Ben.

>  	audit_log_format(ab, "pid=%d uid=%u", task_pid_nr(current), uid);
>  	audit_log_task_context(ab);
> -	audit_log_format(ab, " old-auid=%u auid=%u old-ses=%u ses=%u res=%d",
> -			 oldloginuid, loginuid, oldsessionid, sessionid, !rc);
> +	audit_log_format(ab, " old-auid=%u auid=%u tty=%s old-ses=%u ses=%u res=%d",
> +			 oldloginuid, loginuid, tty ? tty_name(tty) : "(none)",
> +			 oldsessionid, sessionid, !rc);
> +	audit_put_tty(tty);
>  	audit_log_end(ab);
>  }
>  

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
