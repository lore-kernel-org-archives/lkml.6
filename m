Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81AFC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CF0218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dynamicaims-com.20150623.gappssmtp.com header.i=@dynamicaims-com.20150623.gappssmtp.com header.b="kveN6Dch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfAaSoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:44:37 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39296 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfAaSoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:44:37 -0500
Received: by mail-pg1-f195.google.com with SMTP id r11so1727100pgp.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 10:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dynamicaims-com.20150623.gappssmtp.com; s=20150623;
        h=to:subject:from:message-id:disposition-notification-to:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=tf18+mmRBRXtie3RGU+TRGgs4y98cmOrdUpr5oRWQrw=;
        b=kveN6DchXCuxHrDpD6piDiWqrx8BugSZq2tg1/WP61evajlpHStuFkNe/Z9buaecp1
         ZemX97blhXwpi5dWRBJwZlll5PMT6DTHnXIfd/jE4zKe58dWBmu3ca91FZ9XSFTJA9hk
         8JL2ma5P8XfrU9I/jjx7yNM3pBTHzVLEf6fdchbixJtKUdfcyziVxPu0pClC7lsCnA1U
         CM9tU2F0UsUSTKADoBYcmr6ZqgiEiGsh6fMfHNh47JPP6XxIUalRTZVb2AtzzZambJMk
         LY0TUQ0oDP7WUz1JgDFYVjswNuvASqfXFHpn0tq5cMtueGCRKaF+7TOVR68devVDw6Sy
         sSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:subject:from:message-id
         :disposition-notification-to:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=tf18+mmRBRXtie3RGU+TRGgs4y98cmOrdUpr5oRWQrw=;
        b=s/umWuIVYsZlRfz92ir35Fnkab8IoxXIARxJkpESJxNk1O35I5R7dF/5ivCQofMcRb
         l2dtJufcrD7wKY11wUm+Iq+e4YH8tzoNbrq0LgbIdYZEeS70MbduWIkQOlV2PE5bPvI4
         d4iv/mLrci1527gqY+Wp6mq3AgMMHIamhpQJP2c6LxiskfAwpeiaxZcZrHtSfssjSW1A
         p7ipdSpN5x1cQJspJbwFtmdI5vEknGxtZnCAbUgHAtvZlgGrP1aIs5jxW7s4JsG1bpu0
         I7+RnTjoiKbeZaBozAJuxNOoZYkThvZq6WRZk9sFHIV8KkcmCL8Ej1vXICIwwZKvISN0
         IQ6Q==
X-Gm-Message-State: AJcUukcsojbpn0p64jRoVhQYt+Unhe76GbEz1An+Ri6kbEFZ1nhUiUeQ
        M7IHWN9TTzBKJPkS+jlcKSHABvMksfs=
X-Google-Smtp-Source: ALg8bN6LTt/A1kIiXL5Sx+PY4CdYDmlOqanIr40HVbTjruABpFEfaXVtysv557I2WfpcGXh8c3OSdw==
X-Received: by 2002:a63:334a:: with SMTP id z71mr32841546pgz.400.1548960276604;
        Thu, 31 Jan 2019 10:44:36 -0800 (PST)
Received: from [192.168.0.229] ([43.224.159.177])
        by smtp.gmail.com with ESMTPSA id r130sm9175621pfr.48.2019.01.31.10.44.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 10:44:35 -0800 (PST)
To:     linux-kernel@vger.kernel.org
Subject: Pool Owners List
From:   Carolyn Williams <carolynw@dynamicaims.com>
Message-ID: <4dcfbb82-5389-1569-6cae-e376970f4ced@dynamicaims.com>
Date:   Thu, 31 Jan 2019 12:51:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.3; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Antivirus: Avast (VPS 190131-0, 01/31/2019), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Greeting of the day!

Would you be interested in acquiring an email list of "Pool Owners" from USA?

We also have data for Home with Pool Owners List, Real Estate Investors List, Condominium Owners List, Home Owners List, Real Estate Agents/Brokers List, Mortgage with Home List and many more..

Each record in the list contains Contact Name (First, Middle and Last Name), Mailing Address, List type and Opt-in email address.

Let me know if you'd be interested in hearing more about it.

Best Regards,
Carolyn Williams


---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus

