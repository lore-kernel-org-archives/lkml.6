Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84639C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE5720693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tG/CFyoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE5720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755706AbeFSFJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:09:35 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44165 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755632AbeFSFJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:09:34 -0400
Received: by mail-lf0-f66.google.com with SMTP id p23-v6so16375610lfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 22:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1RWo912SA7FdIReCcR7k4aGANM8gIqjuHlPkZ4rxnUs=;
        b=tG/CFyoeJWoVPiHr8B6zQI/hO9zUiN5hQ/OOtBXFlYSGkvC7fBx4YsDpJzn3DR4Q6+
         i9yGo9MvhhTHMJVzJLpqv1CQRV/8xLWHCBrqRN3vm7sHYD0jhDaLO6zE5/MfXt9u0/b3
         QfUV/sH8oDCA81k7BOFWeyxipxlii0dRunyQ0P1bXrg5MYH2I4aO+fLVeMKaLUT3hIdP
         QdcaYK+9gq+IbAAFTuY4hUPh+gl70dmceoEiTS3pvEXwplkZ0keEaVt3MjD6MRQrJ6qG
         JXF+RNPoOPdmrvLvRawKXilLbGaN+exksPennegZG7PMVFnqROa1BZx6aBsg8tkdZCJb
         SDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1RWo912SA7FdIReCcR7k4aGANM8gIqjuHlPkZ4rxnUs=;
        b=DWCaIyzgzxYjDB62dNWGq1w39HuwGpHYC/90q18yoi78CXeOHtGw9k6MONM+ZyhNgg
         Eu5ZqyOUFf1flMAZO3ru1HT3jUOcWAMHc4hCWF7Ej6gUXkmh39AxjCMAFXbXdym4mvE+
         c6METI6j5mlp4w2yyBnvP0PxwzVO3s3Tof85/Ko49Yz7l0D1AWqKflGYaXfU0ci83bBM
         +/J+o/sUdyrljw+no+W2qC+6Nzdu5r8lpEJ18MgO0AnRDvygOxxJjq0n7lMPDexZz+Ih
         xA9/A+1ik3O7canfkhXW17xo4sYxC7pv5iEOiIFtM+OxUcYY3fqKAocDbdwC0NDtZpMx
         HPfw==
X-Gm-Message-State: APt69E3UdMaJdF27o0/ncv0w8qWQ1o+ew3ddwNzmixE7d/6FtinLl/nh
        8QlZ1SRLF3D+5MFgtERhK5Oms9uQnYu1Kaxy/Ms=
X-Google-Smtp-Source: ADUXVKLM39eIHkPYBCRWMbRksDEeOwYndP9xk6O/DTsQul2AielrhfhBvlTtkY1rrxMbsMnrA3KLxwO0pGBDr/EEowE=
X-Received: by 2002:a19:2544:: with SMTP id l65-v6mr281632lfl.84.1529384972945;
 Mon, 18 Jun 2018 22:09:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b43:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 22:09:32
 -0700 (PDT)
In-Reply-To: <5c6942da-c847-c53a-a571-4ec96f2a993d@linux.ibm.com>
References: <20180611202904.GA25538@jordon-HP-15-Notebook-PC> <5c6942da-c847-c53a-a571-4ec96f2a993d@linux.ibm.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 19 Jun 2018 10:39:32 +0530
Message-ID: <CAFqt6zY=rpak3NGUMcCupvLp_RCwLMCtwfnBBjLfSc+U2vQ3OQ@mail.gmail.com>
Subject: Re: [PATCH] misc: ocxl: Change return type for fault handler
To:     Frederic Barrat <fbarrat@linux.ibm.com>
Cc:     Matthew Wilcox <willy@infradead.org>, fbarrat@linux.vnet.ibm.com,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        brajeswar.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 9:36 PM, Frederic Barrat <fbarrat@linux.ibm.com> wr=
ote:
>
>
> Le 11/06/2018 =C3=A0 22:29, Souptick Joarder a =C3=A9crit :
>>
>> Use new return type vm_fault_t for fault handler. For
>> now, this is just documenting that the function returns
>> a VM_FAULT value rather than an errno. Once all instances
>> are converted, vm_fault_t will become a distinct type.
>>
>> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>
>> There is an existing bug when vm_insert_pfn() can return
>> ENOMEM which was ignored and VM_FAULT_NOPAGE returned as
>> default. The new inline vmf_insert_pfn() has removed
>> this inefficiency by returning correct vm_fault_ type.
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> ---
>
>
> Thanks!
>
> Tested and
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
>
>

Frederic, is this patch queued for 4.19 ?
