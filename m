Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3096842-1526412930-2-2786791800651764121
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526412930; b=Dn402ZYQ6JQfEsDEruLcXCpPlYeW+eP5mSHQonW2MEFo5iEigx
    AS0cWhcoBITb+q6TfHrEDUHpJ6FNkBs3fUd0lUUTvu0QTl1AsZVlqSsfd/CFxLj6
    J2d6adLm4HqQ1NlASJlXFgQHYqnCKiPARJIp7V0SwLJL1tllHWnarXcW1NE5iUEn
    M07jFMc9eU5hjzGJiLzGihIRkO/I6Aeit2UmoFHHAfXuSAmplhlcNgjWqk1j9IRU
    uLjrCuXLyOlhst2YVJYk+OV4AXpsyauxcr9mYjQTBux2tBhowfgp3WYLEW5MIvmi
    G1q8+ew5M4k0qvt2KNK33/TjCyzK9K5B4AtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526412930;
    bh=5ah1BJIf5rDl9vwY1Zj6OxDlrued2t86OpVBGswSSOQ=; b=b9d0Zr13BcN7
    rdydjT7vjO+60QBM2rXhEaNpPg+B24YM/Egc0EFsjHH6MVBUpwXx5dyH9LCfms4f
    CztMGbwoOm26ednw260/KF+sh5p6dfIsXLQcduc4cAGM/C8JxOozJH4mFNZIzjZC
    fQRClZu1YK4OljzRnChdW8xncwaAjaXirT9MO2q9Asa6Pcq0Vg28eTQz9s60Ood8
    J3d3asASapZuP3Qi/c/lJBC9YRCXooX5Pf0UwrAD9gcW0OjyAVL2+Fm4yzkc/On/
    KrS0rLoGbHHFNSRK93KhaAxQ/3VeX4tFOoZJid4QufFv36T3J2CEWBoMTqZXE5ZQ
    NSsfboZkIw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfHqEyAGFn+Gp9+EBYInLShRj223Vt23dpMli3+fGbOieJpcGwAuGvqrBejSBfbdcGnY5HJEYd1nSitNhFaaNnEPJoay89EzONvpD03+ApfruL7ISnUmM
    yUIQhmoRV23hjvWGc0NxVygKFXaf8xwj0a/4z7QweuFZy13az5wXBKhq42sk9C62bEvZ7w6iPbJgSA1dX7aPgvbVUGgAA/+yGDCkLNCqL4c7vg/ZRJK1AF1c
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=8AirrxEcAAAA:8 a=TUnNT5ntPQKMPpypX8kA:9 a=QEXdDO2ut3YA:10
    a=ST-jHhOKWsTCqRlWije3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751402AbeEOTf2 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 15:35:28 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:57701 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbeEOTf2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 15 May 2018 15:35:28 -0400
Message-ID: <1526412924.9159.42.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 035/190] ARM: dts: imx6qdl-wandboard: Fix audio
 channel swap
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Date: Tue, 15 May 2018 20:35:24 +0100
In-Reply-To: <20180411183552.238086370@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
         <20180411183552.238086370@linuxfoundation.org>
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

On Wed, 2018-04-11 at 20:34 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> 
> [ Upstream commit 79935915300c5eb88a0e94fa9148a7505c14a02a ]
> 
> When running a stress playback/stop loop test on a mx6wandboard channel
> swaps can be noticed randomly.
> 
> Increasing the SGTL5000 LRCLK pad strength to its maximum value fixes
> the issue, so add the 'lrclk-strength' property to avoid the audio
> channel swaps.
[...]

This depends on:

commit 570c70a60f53ca737ead4e5966c446bf0d39fac9
Author: Fabio Estevam <fabio.estevam@nxp.com>
Date:   Wed Apr 5 11:32:34 2017 -0300

    ASoC: sgtl5000: Allow LRCLK pad drive strength to be changed

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
