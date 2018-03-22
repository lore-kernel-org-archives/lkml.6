Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2911704-1521728437-2-429177730263322108
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521728437; b=P+m7J8/VDfqL+5fGYISexFr6NTsTOelSM95wSQp/a+b4nct
    z4vyyD6WIW8SWn/vXzqmug1ICI+Ec+u9/VCLLv2sVSWaO1xt4ZwYl7Lp3FrE2OkR
    pYXCbG3QSm4YlvVPLOT+753zPCp5OTPrssn4MNXA9WELQfVzOxZAUtRfKelUqdcO
    dI1My7OiX44mRhY8B21HdPSitrX6lsiHRDc+3+8+t0PmAhDe1/8PNW411kFspFjW
    XLyv/NrDpxW96zBhIraOEXY9biT3Yg2hbYcCjdPbmy0bvXTquRIdZ16l0fC3yGfo
    6kBlHyw4MoobXkW11XHi+urAqRLM/pXmG11dxyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521728437; bh=X17Qey25cngUZTIhXOaS9Al+gQHgIUJ+WCCObMyjOvo=; b=c
    PBOSRctneg6tbSswfF/QDKcFi7WpnN1DcEyrtygM8+89hPbZKNM5Evp1oTj1HKl9
    Zog1IipRu/I6Pd00FWqCUmuHdZxwgpB5Ig7G5he+CN62bdCiHJxt/JK29HslldHQ
    4Jcj5mYQL9ta8imwOTEKCnZXJm/lLj69VyIHXaWg4Ztdj8MdzhM9BkT+HTtNACtw
    A+btK0IEnjt45QfIFeKEhcEuZDXi2EHyYolinTVfN0+H/K88YtmPE+1phsfR8wni
    sGuo/F1ZX01VNmn0jqVJUsPImUGvSu5pn6Zu+xFKRN7PnXVPlfiUz93ez5PlbvGL
    sVQV/0Dud9JlMPICkcXsw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754954AbeCVOUN (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 10:20:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:28521 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754900AbeCVOUL (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 22 Mar 2018 10:20:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,345,1517904000";
   d="scan'208";a="30330353"
Message-ID: <edcff887ff133df486812bb5ecadcc101bc1d227.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: allow TCPA log area to be empty
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Sahil Rihan <srihan@fb.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Date: Thu, 22 Mar 2018 16:20:06 +0200
In-Reply-To: <A799BB0A-C44B-41AB-9C38-4B974A50210D@fb.com>
References: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
         <20180312150231.GA24717@ziepe.ca> <20180316125525.GB5035@linux.intel.com>
         <20180319021323.GD27186@ziepe.ca> <20180319212436.GD14364@linux.intel.com>
         <A799BB0A-C44B-41AB-9C38-4B974A50210D@fb.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.0-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-03-20 at 22:29 +0000, Sahil Rihan wrote:
> > On 3/19/18, 2:25 PM, "Jarkko Sakkinen" <jarkko.sakkinen@linux.intel.com>
> > wrote:
> >     
> >    Sahil, would you care to try if this fixes the issue that you are
> >    having or not?
> 
> Yes, we can test this out. Might take a day or two.

Awesome, thank you. I'll add

Reported-by: Sahil Rihan <srihan@fb.com>

if that is OK for you?

/Jarkko
