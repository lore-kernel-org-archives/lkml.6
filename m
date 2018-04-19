Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3082590-1524141078-2-173804112683476561
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524141077; b=m2DkaOAKZrZk7Th8xGoIFjp5omCNo4nz7st7LXc9lZPDnlCxhF
    DPf3nlpAOyTPR8RN5QWXs3Bpgwx71uGtMPHXYQRcFtQ8KCa/lhvqg7GDkssqaRZb
    H4MM43tBPngxY9I+fngkqQYwEN2uIYuWQvgA47ETPwQTNHYC0I62j62k0kfU+zBy
    eHfkXyZhqBuFffonYA+St+v2pYWAwU38BcuAlpxV0ElCvKAHA88+kOA3hBrlJjhH
    O5temXsvK8hgKsM86ekziElIUVbXSliXT7L/JfrWWS7T9NjfwpKT/35JqRiG8ibM
    TEIC8+AB+BM3CW+LzK5z/OlfKFM5M2sNZ1bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524141077; bh=POVMA7oWxGadnu7nvCviXV1QKyJjA7yScC9+EbM1Qh
    4=; b=rxsaChB8B8Y3FgxEsP2kGzuPFYAsdhpYJUV/QQHsby6umDnyTptzAxFYda
    CjUmEw2iIT0NggfUWegwb5XWWtMI+MB8A1rQNf184vbdCHrd7yzgNSLNzzPk8C7v
    TxWAIOHwgs+zRrnOi7QhtjYgvqtLUNx67JID2rkNX0bFHJLMMO7IJfsqwSM9FAgf
    ypKFDeVOkWhh+vlYdNdNXai7vOhberPBBkdK3AVoluWW8BWpnnDe+vL6XS/JFkbB
    xN5eX6/v8WpRV9iEwAqA9CvegBkPBED9D5Lf+rDC3YWKrnZybtil6gZIVUjUtoOT
    OkGHL3/0EHStmCBXuaopGSfVr9jg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=EWd2Dw6O x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=STIOFSrd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=EWd2Dw6O x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=STIOFSrd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOHIEvpghEvtfdWt6gUC5eps8KQmAhEW03TRVPa+eUu7ODP0oSOKRxJciErCO+NRBLi7+Gv08zet2EQWOyi5yGg+CIfrnBHCRKYbkFoYJBdR4DoUAH39
    WYgskY5w25GYFG6Td96fzyx6sC+aw6CgG5Av2l2DoxBPtSF24YaIff424Zz5KUJMB2WQ67zIATwLwUl1kTe06+Ki8QI3Ergfcis0uhlPTThPG4WAK8HufAAv
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=J7Nbbob27coA:10
    a=Kd1tUaAdevIA:10 a=1EsaE_6oAAAA:8 a=mj2sUwuRP3QCkLGX8NEA:9 a=QEXdDO2ut3YA:10
    a=3ZumFrijQQ-2J9H5h8ct:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbeDSMbQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 08:31:16 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:43735 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbeDSMbP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Apr 2018 08:31:15 -0400
X-Google-Smtp-Source: AB8JxZooaINotPr+oyBQo9OCIYTGBbvCbWKmxYcQF55EAlDCtSpgyYedm/7PqM1LBGiBC1Fb0wmdD8zlPQMuHWb6Se8=
MIME-Version: 1.0
In-Reply-To: <1524139760.2587.17.camel@codethink.co.uk>
References: <20180417155645.868055442@linuxfoundation.org> <20180418174244.ke5n4uhbj5geijco@xps>
 <20180419075608.GA4230@kroah.com> <CA+G9fYvwDU481Ui6cAC2ORi+A7rikx=ZGrLew5bAepkMY3wqrw@mail.gmail.com>
 <1524139760.2587.17.camel@codethink.co.uk>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 19 Apr 2018 18:00:52 +0530
Message-ID: <CA+G9fYt_Tv89s2DNS9n38DCaSu73e2381YSG9J-Ruv3UAu8FPA@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/66] 4.9.95-stable review
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 19 April 2018 at 17:39, Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:
> On Thu, 2018-04-19 at 16:42 +0530, Naresh Kamboju wrote:
>> >
>> > Can you try 'git bisect'?  I'll hold off on releasing 4.9.y until this
>> > gets figured out.
>>
>> After reverting this patch, network started works on arm32 x15 device.
>> d7ba3c00047d ("net: phy: micrel: Restore led_mode and clk_sel on resume")
>
> Does that also fix the hang during 'ip l'?  (If the hang only occurred
> on the same systems that oops'd in the micrel driver, it could well be
> because the task that oops'd was holding the rtnetlink lock.)

Now 'ip l' works and the oops message is gone.

- Naresh

>
> Ben.
>
> --
> Ben Hutchings
> Software Developer, Codethink Ltd.
>
