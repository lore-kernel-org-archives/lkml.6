Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45314C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 03:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0B520833
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 03:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVyNXGBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0B520833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbeJAJvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 05:51:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42596 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbeJAJvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 05:51:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id i4-v6so7783124pgq.9;
        Sun, 30 Sep 2018 20:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SNgKfv1LdSvWfYgtG/rqWiS740V3nGrgdVWgKRkW6PQ=;
        b=iVyNXGBwu3cg0NY1GdcmxR33QB8vNc1m604nedeiJ8p2vTWG9EloZKKgXMVsCP5oO9
         UccdXefhgkX6CK3ayFFUCMhjCVsozxA76OGzr3nGXMcC+0VlFynnnRUeMUMcNs31v5A1
         ktbtTro/YW8Jh3oJwAsk9xXuMQYN9Um8YeyuIlyfuoSOker16yHk5+fYfXQ+xXP7DhAB
         IMS12/M3G3N8aNOg14m7r2bmN3BggliQfDCXY5qt+woYjeZiWzR77kb8JbD7fjHCFoqM
         VqaAjiYrfvu4lnddpoqkSnL6FeVRIMJuw8yl+RnlyEcPuvtCjku6X+MebD1b5Ja0AzTB
         Sk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SNgKfv1LdSvWfYgtG/rqWiS740V3nGrgdVWgKRkW6PQ=;
        b=sYqdGDTEfkC/B/9CZaUPuPIaK7btT6L7EoGWiy52jcP1JDZ/RDNxK70YOpu5AE5HTF
         lOD5ltNpuC7YlByr3sJQankJmj/ThZXd9V+X2E4OOpgtDCmht/EWO+Rx8HQX1Ee3xQEO
         PuWZd09I/Pz9audo0jnfFCq5l9AgDon0KMYAXgYHTLgv5HvIB3Fjlgkxc5DGxIhS0R5r
         fAVh+cvSopJjhBkLiOtPG1T1YSZ5Pd9uPJ9WcdyAWaCCln7+3sEaEYJQj+w58jhdUqrA
         1RICBNQJwfxYh/yDGrLt1zRMuDIuign2CtmrTa4n7ZHRep14CW4kKY5EF9Qw8g1OVb+F
         mAtw==
X-Gm-Message-State: ABuFfoiQ7DUCJ3yMYJPrGEmTceMZEEoEAbwOLtIblbxcXWpU65t7meTH
        L0DFlN4HgA/AD/jcasllrIY=
X-Google-Smtp-Source: ACcGV62DZ901ZvhvKBZY1NhGnffYqpOWSoXSWhcB1bvjthRgTymMdjh//BFPoEBS3WC1nTJnpdGSKg==
X-Received: by 2002:a63:61d0:: with SMTP id v199-v6mr8561296pgb.242.1538363743509;
        Sun, 30 Sep 2018 20:15:43 -0700 (PDT)
Received: from Asurada (c-73-231-2-134.hsd1.ca.comcast.net. [73.231.2.134])
        by smtp.gmail.com with ESMTPSA id q25-v6sm22469412pfk.154.2018.09.30.20.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 20:15:43 -0700 (PDT)
Date:   Sun, 30 Sep 2018 20:15:35 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, afd@ti.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] hwmon: ina3221: Add suspend and resume functions
Message-ID: <20181001031534.GA4428@Asurada>
References: <20180929214407.27208-1-nicoleotsuka@gmail.com>
 <20180929214407.27208-4-nicoleotsuka@gmail.com>
 <20180930152749.GA16746@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180930152749.GA16746@roeck-us.net>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 08:27:49AM -0700, Guenter Roeck wrote:

> >  static int ina3221_read_value(struct ina3221_data *ina, unsigned int reg,
> > @@ -415,9 +419,67 @@ static int ina3221_probe(struct i2c_client *client,
> >  		return PTR_ERR(hwmon_dev);
> >  	}
> >  
> > +	dev_set_drvdata(dev, ina);
> > +
> 
> It is better to call that function before registering the hwmon device,
> to avoid the theroretical possibility that suspend is called before drvdata
> is set. I moved the call accordingly.

Oh..I see. Another lesson learned. Thank you for the fix!
