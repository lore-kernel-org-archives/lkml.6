Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1679646-1522766566-2-12174135649432492778
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522766565; b=bSdQYJ3DuNwGmE62C0TxwR2qNcJHU3fb36qO7wBVBH/7jmPP4O
    zo/ALrim/Ulng0va4qX/nrdZByTYAFjrGr6SIyDO3Dfu+dZ/jroC/WgyWCP88QS6
    CciQsdZEtyhwVT76qoXuc8QIv4TYq14pamBa/JosZefPNG1qntJCtV/7dJuXa287
    KiAurGF9el59GzSCdnvAjzFKQ41oOs6iX/SHnh6iRtgYtNQ8LZxk8TC+nhkp1+Bl
    4HeMttuB+5RKxvzKZt0upkoC4u0+o5T+moy0S6J/EnA/N15ChCAFnerlkf8d55El
    ZpYN5GEFOTtwtU3nEauq/x3wO/T6nkgoJpxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522766565; bh=xHDnZMEyufTeaIYB6cAeqX75rT1uyP
    I8iWaFe8MLXVI=; b=pm/KR8T8kJm/mGOv78M4jxlxR4rc1VGepqQ7s+8lmJtyRH
    TrgtppU46voitDcoj3Xonx4bhDI+SCZFpPxqDvPDMMTPacEJeYLTv27kyoQkGcjz
    GXUo0Ob1SO52g/kn7/KaJppKoeXKujMTHV78u6B0PHArMvLBpIbYgTbbV2v9jBb3
    oixiRjXga9uY0BphpHSwTEon4QKlFC49pCT6pPopkeLsF6RpdbMpvJGT6E4F5H/o
    A8Fpt/D2paTNzb6qIJfwJ4BUzqgvguoibV3DzakCo4r+luVD5FRe/Alvj2XYOfZ2
    bCNHG4prkNjx0ua3olWeYBD6vosieHm4iKHj5FxQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=free-electrons.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=free-electrons.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=free-electrons.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=free-electrons.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJim7O/0RXCUuPITrgL51bl6BYTmieGzGIQM3TBo2gZxEwOiRlvPF8Ubyg7FVv7o8eOx/FuEOhKLKJp/mDStKPH3d2fnpKMhkIYwC8kCwt9D4nDTE+OX
    b/zDdT9CFkSAs+yDrzZRkQZM6TIp18DWczbAaFCvc5QqlkPQPXSf56chKMOLfVSdt8H54Q7Jq27F7b/SY5ZkYMTrvUQOOGW4iK9L90qNYFmzUsudU+vYo0yA
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=voM4FWlXAAAA:8 a=P-IC7800AAAA:8 a=eEVv-sVUkOqP2Tvg_WMA:9 a=CjuIK1q_8ugA:10
    a=IC2XNlieTeVoXbcui8wp:22 a=d3PnA9EDa4IxuAV0gXij:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeDCOm1 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 10:42:27 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50227 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751543AbeDCOmX (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 3 Apr 2018 10:42:23 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on mail.bootlin.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT
        shortcircuit=ham autolearn=disabled version=3.4.0
Date: Tue, 3 Apr 2018 16:42:11 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: Trent Piepho <tpiepho@impinj.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "bianpan2016@163.com" <bianpan2016@163.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "guy.shapiro@mobi-wize.com" <guy.shapiro@mobi-wize.com>,
        "Frank.Li@freescale.com" <Frank.Li@freescale.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
Subject: Re: [RESEND] rtc: snvs: Fix usage of snvs_rtc_enable
Message-ID: <20180403144211.GM14180@piout.net>
References: <1522264445-2398-1-git-send-email-pure.logic@nexus-software.ie>
 <1522282337.10662.268.camel@impinj.com>
 <f380bc29-c8dd-5c20-efc4-ffc0ad69b8d6@nexus-software.ie>
 <1522450739.10662.278.camel@impinj.com>
 <4f9434c7-6977-caef-2fac-5da79364304b@nexus-software.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f9434c7-6977-caef-2fac-5da79364304b@nexus-software.ie>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 02/04/2018 at 23:51:12 +0100, Bryan O'Donoghue wrote:
> On 30/03/18 23:59, Trent Piepho wrote:
> > However, I think that even if the driver fails to probe if there is a
> > timeout at probe time, it's still possible to hang later if there are
> > not limits to the hardware polling loops, such as the ones I added.
> 
> I agree with your patch in principle for this the reason you've outlined.
> 
> My patch though should still be applied to fix non-starting @ source.
> 
> /aside - I don't have your patch in my inbox - if you could resend and cc me
> I'll review it for you.
> 

It is available in mbox format here:
http://patchwork.ozlabs.org/patch/887090/mbox/

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
