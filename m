Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64C2C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713E921501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGTHXGU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 713E921501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732365AbeHBOrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:47:21 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:44888 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732110AbeHBOrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:47:21 -0400
Received: by mail-qt0-f179.google.com with SMTP id b15-v6so2073601qtp.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 05:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GLyB/82VIzTzdmHxzT2S/kEVm7jpJGLASkuCq657Awg=;
        b=CGTHXGU02puxzzGUBuDIIREbNcbzEZSvx170/XibPIOATuZuv/2mqP9ZMCbNpYi9dU
         IwKpiJY421HOswTMm4ycb4Zm1bHFsU8n8xNpWAteHzX9z/gLl/gBAaXd7wIQdjjGVPs5
         4oDRIojCCNvkYUdaZCYKDMU2onIynmEtJeMnZowFZjeOKElDZQ7Tf+b9sW8IkegdREBs
         Vk8zj9WYJ/fSmen3NDmhuQnwi2piIEykd53BIkaAH1QBsxVKZ2W7uP3GAZSa/F0etBQk
         D/pOhnWD60Fjms4drSpUNge7wLsQN/Ugzc+iVUBheBWoSEZaEF8JRB7nece+Y4RX/7I9
         c0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GLyB/82VIzTzdmHxzT2S/kEVm7jpJGLASkuCq657Awg=;
        b=G7O/KzDH+op/nNNVbyERrwq9lkuyH7aSfZ0mvZK6uqr6mnqsT3kAGdPkw7l+jR6xHY
         FRuLqO5b1I+KqWD9o30pAtFybd6TZiP3F018HHtsmn5DCpVbXjgs7kNxIV+DxVYuIUXc
         toCgqTN0v6owTQsRIbmmUEDQfapTQ6bzsU5Woi3nmuua5qKvW0bxF11dLX2kbA6npFXK
         BUbJCxHLVgHMWk5OUMwI8UoMumjrLKN9L29PoO3UwLzkXOND/uTcyl6B2wsBnWMAuYed
         FsjrVtLjymKxy5kuSU2tVaj6bP/2NmzE7Z0igClE8dteYzAS9tf/G/230Hz04U0Sro4E
         2v1w==
X-Gm-Message-State: AOUpUlGsAQOeWUi0hUoTuVeSQ+qVc/cazXYAeiiu4mKeVV8IwR5XMPUi
        1K4z3FFxxbnNYYVQb9eMetEDPcrA7ZXrSXdl3UY=
X-Google-Smtp-Source: AAOMgpc+4X9Zc2zuKUw+du4bwVYSeON/igA/Z31gUx629xFc7hMQH+UaAweQ2abY5sjMlj73auv6kdl14CiHCXkYMgk=
X-Received: by 2002:ac8:6055:: with SMTP id k21-v6mr2521553qtm.204.1533214576386;
 Thu, 02 Aug 2018 05:56:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c482:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 05:56:15 -0700 (PDT)
In-Reply-To: <20180802132956.6b7110ed@alans-desktop>
References: <CAAJw_ZuQXrYaEu9_pXWtoDpUjR2au1gGT_FP9F1e1Y7veHSz2Q@mail.gmail.com>
 <CACVXFVPpSJDqR8ki2PiDBbU36KsGFMYsOEf_9bmN6Cpo3w_YoQ@mail.gmail.com>
 <CAAJw_ZtZ8hXi_B6+duiQYpaeSsQ7BQD-KwtE3H6K8Y8O8pAuig@mail.gmail.com>
 <CAAJw_Zvaw8yoyejg5T6CtRFjoS4i_EBYKRVWocpH+mpwfaVC1Q@mail.gmail.com> <20180802132956.6b7110ed@alans-desktop>
From:   Jeff Chua <jeff.chua.linux@gmail.com>
Date:   Thu, 2 Aug 2018 20:56:15 +0800
Message-ID: <CAAJw_ZsAUstFKrMQCy5AguyXb9=oQVecN2+b5G8ubQqLUp1YTQ@mail.gmail.com>
Subject: Re: How to secure erase PCI-E NVME SSD connected via USB3?
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 8:29 PM, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
>> # hdparm --user-master u --security-erase p /dev/sda
>> (returns immediately and does nothing).
>>
>> I've tried hdparm on an SSD connected via USB3 and it secure-erased ok.
>>
>> Anyone working on this?
>
> Sounds to me like you need to contact the vendor of the interface in
> question. If it accepted a security erase command and didn't do it then
> it's broken. It's at liberty to refuse it, or report it doesn't know what
> you are talking about, but if it just returned and after re-plugging the
> device its still using the old keys then it or the device is busted and
> it's not something the OS can do much about.

Alan,

You're right. I wrote to JMicron, and they are kind to reply that
"hdparm not support secure-erase feature with USB to NVMe device", and
told me to plug the card into a PCI slot to perform the
security-erase.

I'm asking JMicron again if the JMS583 even support security-erase.

Thanks,
Jeff
