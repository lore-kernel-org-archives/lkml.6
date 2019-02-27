Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04451C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1605217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dynamicaims-com.20150623.gappssmtp.com header.i=@dynamicaims-com.20150623.gappssmtp.com header.b="Lp92qME2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbfB0QH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:07:56 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33042 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfB0QHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:07:55 -0500
Received: by mail-pl1-f196.google.com with SMTP id y10so8254406plp.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 08:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dynamicaims-com.20150623.gappssmtp.com; s=20150623;
        h=to:subject:from:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=IRIkf3RnJCEx252KTEnk+pnip2j7Rx4Vrrt8nqbKdbw=;
        b=Lp92qME2wqOr8FsQO0HOodCbz6wzyZI1skP5BtnUBpurPWfkjENiP3aGSXcJdx7MBF
         piDOki+jyl+wXhnHbLPx5vEc5WZRV/+bE2HVwiYCO1GRKLjXgwuM+LoSWu2qPyXrkRwK
         J1YYPJC+C9iraeI6qK//2jc4ltQnEfUCKILFPDuJxgNymoUuysgJk/yN4m/peeuZGydX
         Rvz69yIzv97HqgjQbF6sngaWD5Rhfj8hPM0FJcDxSwFr2Qy1SI+/TahifUSeNR5FwiBY
         IRRbFgn8bg7HzhvcZwHR/wsdLEAVRL/SnucOlTm/RpwgmmCBJ65Qm0QH9jK+FwAoju54
         IrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:subject:from:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=IRIkf3RnJCEx252KTEnk+pnip2j7Rx4Vrrt8nqbKdbw=;
        b=MxAyij66KDBytCNioILDenUxU5Rp0/oxcwHdUDXdwR/5ev1J6YjceR04syL8Z321f2
         7ir+DfwkNIS/f8tDmTahD24Cgd6XgVGUfNws/65ffJAehC7JhbaPxzBNPTnsrFsI6T3n
         j4wm3KImDnbq/6CPvGNwnhmTNKrGZtOoYUBaG2jkRJxPHEYSTywADSSbgEZu3Rovj+Oc
         4BXxaoOHR1B5JM89khtiRzPO+TaX8aPfcCOVDFBFRvIE/q5MfNMJV6LQ70rvALfcNX0k
         x9Orap/q6qI/mBWo2erolQOS0fe0Gembu/jVluTarRA4tgv7kaLHtsv13EPFwstGwdKZ
         Zpag==
X-Gm-Message-State: AHQUAuar/A0NBsWKDpniyfLTm+QDDfjlKn3IIsZz093xpkBATNMfwf9I
        t/vV6Nwjt7Jo185oQ5nVHSb9NwmqA50=
X-Google-Smtp-Source: AHgI3IYSFYbgvA+ndOMO52ZWShyCUW2EPqh15KmZCLyIgM7SRtwtA/bUbc06jerDdR/dzY+wyXrA3A==
X-Received: by 2002:a17:902:bd06:: with SMTP id p6mr2915597pls.130.1551283674754;
        Wed, 27 Feb 2019 08:07:54 -0800 (PST)
Received: from [192.168.0.32] ([43.224.159.177])
        by smtp.gmail.com with ESMTPSA id e21sm40976651pfh.45.2019.02.27.08.07.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 08:07:54 -0800 (PST)
To:     linux-kernel@vger.kernel.org
Subject: Valid Wine List
From:   Stacey Parsons <staceyp@dynamicaims.com>
Message-ID: <73e25ded-62e1-0514-fd27-ac698e8e4f21@dynamicaims.com>
Date:   Wed, 27 Feb 2019 09:59:32 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.3; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Antivirus: Avast (VPS 190227-6, 02/27/2019), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Would you be interested in acquiring an email list of "Wine Enthusiasts" from USA?

We also have data for Beer Enthusiasts, Liquor Enthusiasts, Beverage Enthusiasts, Spa and Resort Visitors List, Food Enthusiasts, Entertainment Enthusiasts and many more.

Each record in the list contains Contact Name (First, Middle and Last Name), Mailing Address, List type and Opt-in email address.

Please let me know your thoughts towards procuring the Wine Enthusiasts List.

Best Regards,
Stacey Parsons


