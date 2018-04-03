Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2496537-1522791136-2-18013011978728827880
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522791135; b=TxtcBigLvJX8K2EXvAkDtODukw4szQ4T9osTfhBbH3AahzF6cG
    L1rObk/aFQNprgUsGHqe8XX9yUnPN/21Exz1ncz7Ttx9ylfkDOpFSIzZ/fIy24mQ
    dC3NKmV+SPHV7Gz82rfEGeNfsBym9N5qqBPF42NdHbOAp3JBGDHudu7C41e10Xbn
    5kbruqbokC0PWlI4vt7gCYWpg0678FpQfjysrwQ8aY/W1VONKx99Ec+D2EiwayEX
    OPv+vBbXPTo2o3rwu1DCbr0VWQM/YO7XIYwkRaPmgNtTYAfvRowZs00fzM36Q1L8
    fioTuO5DXm751FRGrpufUEIGT8guAjrlfmLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522791135;
    bh=kjwust9w+ahECrdmSErApmMlhcc7DUAWdQqDYhvl9Vc=; b=W/M1eQv1J6wo
    A8rta8o4oxjgbwsYaymTWvkzpJiWHmSav9pOAZ/RAzVgeZorjI9lg2pMQU+NY6WC
    OWo8wbdt251CqE6FIvnc3SplmFb05OXsMDGlZkZRwbdDHvtszwtUyL52f+yYeKIS
    TxDbfCI1rZA3FygmGVlWHhgCmCnAqthO0fXX6Bm3Erp3VnDL+HmNm0BnGpSXbHs/
    B1aWLrVx2y2vAd6ZLpHAN50qA0m9pJIHHDW0IYRowU64mDyhbJG9VtUMIRAzVQ/G
    emuDSY5QH/GTrxu9HNZGnHebEDDy2hsatl7d4wN3Ru3KxuPSiOJhSh4lXfmv6ER+
    VjZ0cLme+Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF4QIa6hD/IkIGunKg+MXphIwXE+/JXisJiRpr4Puu68fK7PwtjpGXQLbZIzDKTCufLcjusEdGD8u/KD8ICPBp9ojLiVp/Re/BOl1lPMkvEiT0tCj/iS
    rwAhD9Yr59tnAy8IBnNiAjjT4IMroP3tNXqMqHIA8U/bK6Wy9yOP8OBc7p9NK1pRP3tsr1DiJQDuX+bwvxZcZyTwskvk4SCKcjanKBE7xmN5YUCIuZXXSZj+
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=FOH2dFAWAAAA:8 a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=9s3Yogug9-Uz7RzYZy8A:9 a=QEXdDO2ut3YA:10 a=i3VuKzQdj-NEYjvDI-p3:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753585AbeDCVcO (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 17:32:14 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:33902 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753588AbeDCVcN (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Apr 2018 17:32:13 -0400
Message-ID: <1522791129.2654.135.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 63/97] md/raid10: skip spare disk as first disk
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Guoqing Jiang <gqjiang@suse.com>,
        NeilBrown <neilb@suse.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Date: Tue, 03 Apr 2018 22:32:09 +0100
In-Reply-To: <20180323094201.150412201@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
         <20180323094201.150412201@linuxfoundation.org>
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

On Fri, 2018-03-23 at 10:54 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Shaohua Li <shli@fb.com>
> 
> 
> [ Upstream commit b506335e5d2b4ec687dde392a3bdbf7601778f1d ]
> 
> Commit 6f287ca(md/raid10: reset the 'first' at the end of loop) ignores
> a case in reshape, the first rdev could be a spare disk, which shouldn't
> be accounted as the first disk since it doesn't include the offset info.
> 
> Fix: 6f287ca(md/raid10: reset the 'first' at the end of loop)

But that commit hasn't been applied to 4.4-stable.  It probably should
be, since it fixes another instance of the problem in the run()
function.  Take care not to add the wrongly placed assignment
in raid10_start_reshape().

Ben.

> Cc: Guoqing Jiang <gqjiang@suse.com>
> Cc: NeilBrown <neilb@suse.com>
> Signed-off-by: Shaohua Li <shli@fb.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/md/raid10.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -4044,6 +4044,7 @@ static int raid10_start_reshape(struct m
>  				diff = 0;
>  			if (first || diff < min_offset_diff)
>  				min_offset_diff = diff;
> +			first = 0;
>  		}
>  	}
>  

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
