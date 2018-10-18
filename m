Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60F7C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28382145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=comcast.net header.i=@comcast.net header.b="pFWplwbo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28382145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=comcast.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeJSGOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:14:01 -0400
Received: from resqmta-ch2-08v.sys.comcast.net ([69.252.207.40]:47436 "EHLO
        resqmta-ch2-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726589AbeJSGOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:14:01 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Oct 2018 02:14:00 EDT
Received: from resomta-ch2-11v.sys.comcast.net ([69.252.207.107])
        by resqmta-ch2-08v.sys.comcast.net with ESMTP
        id DB5DgPLsxw1tsDGNWgkzqZ; Thu, 18 Oct 2018 22:02:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1539900170;
        bh=0cMxcKFlvR3SkhhBGm4h7Wwy9fICa7K56nhoxu1VD+U=;
        h=Received:Received:To:From:Subject:Message-ID:Date:MIME-Version:
         Content-Type;
        b=pFWplwbodJy5bDwB1pYQAlnMwpzSDJX11KE+GX8zofEGRZtU+fGJNuW6W28q+GEbD
         p+CeDO7vtir9ujZWuMEvYM2+Oo45a2XR9CSipBpgiaQBnvkWyVIqyUMpVKdkcZp4nT
         8mwoDRN4Ee803LCsy3I9trccQ/zQHBLgVY8GGD6xa/E2HgIv8HpvBOrHAv3QeJUiNv
         1waZu9BZ24NVyK7qIcJsiAG0bep14MLs4e5F5c7Z76hmZYoSbV2cApdHWqoeVG/LFe
         BqFHLjj7XUyVllkn+ziWUYWrY73vxckElfvKDlfu57LUfK1y2YkqL0NTWMnpJkdxA9
         7ek1l+35Xn4kg==
Received: from [IPv6:2601:500:8302:75bf:36e6:d7ff:fe01:2add] ([IPv6:2601:500:8302:75bf:36e6:d7ff:fe01:2add])
        by resomta-ch2-11v.sys.comcast.net with ESMTPA
        id DGNVgEQ8ZVJf4DGNVgI10W; Thu, 18 Oct 2018 22:02:50 +0000
To:     linux-kernel@vger.kernel.org
From:   don fisher <hdf3@comcast.net>
Subject: netconsole on opensuse 42.3 with a 4.18.7 kernel hangs
Message-ID: <1912e0c1-5ebe-5d76-2eb0-71d70a28f3bd@comcast.net>
Date:   Thu, 18 Oct 2018 15:02:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGG6PUcGr7XeOBrjRk/MgSIeh4MXTv785jr18mJskGa7OUBDXP7NPcqTtfFErlco2tgzGIYGwQvz2kYN1nCLi/YGoHo/D+zbl2FdAXiXY3V3MtYmQkMZ
 FWLlyw5MPBE2fdBP1Kl1ks3Va59MFbuaNenzO22P3EY8La2sbf2ux3SqUrSsYC2VesIXmEFQbqJbPi3RuiyEiOvXyZ4zm1yip5mKcAV8qhjmsTXiR1Hcp/8l
 xlN/wzIRxDe0SnfBuYbK/UjSXzaJp+eWhAulLdUYZeURDOfEnmfVVlzQ4dfPKMFH
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have been watching posts on this list and see that many users employ 
netconsole. My netconsole is native to the 4.18.7 kernel, and works 
perfectly for about 13 sec ( 12.954965 last attempt) after boot. It then 
hangs. 709 lines are transmitted before the hang. If I examine 
/var/log/messages there are a lot of systemd messages printed 
immediately after the last successful kernel message that was 
transmitted by netconsole.

I thought that anything that went to printk also went to netconsole. But 
netconsole does not appear to be awakened after the first systemd 
message is logged. I have examined netconsole.c and printk.c, but am 
overwhelmed and am not able to determine what triggers netconsole. I 
feel that the trigger may be negated by systemd or some other part of 
system startup. I am running opensuse 42.3 and have not had any replies 
from their lists. I feel it is that the native netconsole is not a 
component of their distribution so it is my problem.

I can forward any data desired output from dmesg, netconsole, or 
/var/log/messages. Any assistance would be greatly appreciated.

Don
