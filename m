Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-348652-1524841146-2-5206920161679487378
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524841146; b=jpNp3O7esnQEKCGuS7gD7FXB3jRpXPd4ULntHPcnkx1LnGx1PB
    +KT22a/0TCy1HelMrdC5sbakTH3xquPjEvqyTMAvtAAPlYye51pi8eLN2YtmpLyV
    v1Gsq5MM3tegsrRL/rOuRpK0tnONvXkVHFmML+D6AONczm54+7uk5R/z+MnI51L4
    AEnzA2YEDW8jO4iXkhjpIJqFRwSVAjbhEWzrd4XNG33bmFS1gBj71A4Nc9NXnW4m
    wN/TXo96Qzj3R7PIL2QcIfrPtDYBcZ452CnKOoXvA3JxiwbiGPt/0uo6moP/gnFK
    zsUZlKOdR3DsbweoG+T3R0MJqWjWOup0bvzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524841146; bh=M2cSO
    //ZkeJe9RXPVkiqjhaPX0XruCGFQrOa7OmyLiw=; b=deDlgFcW3eG2IMS9eUKur
    qC2GhrzwbUvXerrzFuD24BCTZyxFodg9QYveQ56BdfT1jBIg9CvoDqROiAIqB0Q0
    W9aDglQ4S3wl48zdwxhH+5A5qLdjoRMO8SjFYbzEpFKd7NwQxQFwCWoCfL75ze9Q
    jv0HwnJ1UhAg9vFWkdTdqrmY/4byAADRlAohKKHRjhFFLLQJlzMEHansy2JDWiwT
    V/tXfHHw9yszsU6JGLJ75gvSJJrCm9stgD5X50c8X16Y47geb2Dw4SvyYcIFlHc4
    wlSPof0YNMUpfIy1+qQIK/2qbmJmXs4LcomVOBAwU2CYASg7QrjdN4TxQrY5WUTT
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBuijy2ExCvyuQiNrrPbJ6k52Xc9OC3zypADqCHVRVJNQ4sCFLnvkPC6NhwgdvG4uesarOK8tOAlI+w8aB3xEi6jvKcWskSp4U6kYtMymhbiYoPIAtPf
    1ba3aWI217aqfYa+CtYQKMfZtpg7C0A4TUEY/NRqgotC0PeCxWPENawyX3QWZY5++YM10h118hI8ZXupoXpd51dcXdFttJHSbx3kw5Miq4UEHNHsI3++KIbN
    IzsL03N99OF9LOEXJhAg8A==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=8AirrxEcAAAA:8 a=DDOyTI_5AAAA:8
    a=XDUQrFXmi22zkTcyTMkA:9 a=CjuIK1q_8ugA:10 a=ST-jHhOKWsTCqRlWije3:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3DB218A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org;
 spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
Date: Fri, 27 Apr 2018 16:58:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yangbo Lu <yangbo.lu@nxp.com>
Subject: Re: [v2, 1/3] staging: fsl-dpaa2/eth: Add support for hardware
 timestamping
Message-ID: <20180427145848.GA12750@kroah.com>
References: <20180426102349.45222-1-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180426102349.45222-1-yangbo.lu@nxp.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
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
Cc: devel@driverdev.osuosl.org, Richard Cochran <richardcochran@gmail.com>,
 linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 06:23:47PM +0800, Yangbo Lu wrote:
> From: Ioana Radulescu <ruxandra.radulescu@nxp.com>
> 
> Hardware timestamping is supported both on Rx and Tx paths.
> On Rx, timestamping is enabled for all frames. On Tx, we
> only instruct the hardware to timestamp the frames marked
> accordingly by the stack.
> 
> Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v2:
> 	- Addressed sparse issues.
> 	- Used tx_tstamp/rx_tstamp instead of ts_tx_en/ts_rx_en.
> 	- Used DPAA2_PTP_CLK_PERIOD_NS instead.

Why are you adding new features to this driver instead of working on
getting it out of the staging directory?  What is remaining left to do
to get it moved out?

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
