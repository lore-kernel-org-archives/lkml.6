Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92258C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601282087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzaFXs+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfAHLxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 06:53:48 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43333 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfAHLxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 06:53:47 -0500
Received: by mail-lf1-f67.google.com with SMTP id u18so2675193lff.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 03:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bqIv+E1PTwowFq29pJyeluAn6z1FULnn8P66wo1yneY=;
        b=hzaFXs+1llc+1muA3yyF5s58PrkUU/rP2QcIc33UROR8Mczohrq2+R9qZlyUpF8ez+
         qc9y8zeDs+vfHPv5h2iFaao3R3NaLCKs9kg7wLweGKWt9pSFg2B5KIuWcJb91t8dn73k
         qaV/jynuTy/eqO4euurFpaTQ2ye+A2Oty/yWdocurYIKsAIKep3DoN9+BbjLzJ9eVmQp
         lWr9GnZckeSnRRd3oxBASpCWtml31eJrdiBa4lrJi8ejJmDHSZ81qdd/GqFWYNgJ36i1
         vX6lbuUKdgjOPDgVIHjyOdBLEU8P0UUDPC8dL4/LPE6320932zAcVBogDMp77N7P7eHx
         L49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bqIv+E1PTwowFq29pJyeluAn6z1FULnn8P66wo1yneY=;
        b=Zb4BYRMQ/MtEERp04PbIUiCSP3nJ5jarHVDJmbuuMnYAedwqLlnBEkhBiRpUpPU+ld
         T2PcOkd8ThcSzpktBmIdaColMFBFPH1CuJJUYD1syLrdaOWwq3en2BLSKUQIItlmYmPb
         Z1RfbY1nzs2cGFH7iG9UnI+Eb0sIwuviGQ897ow2k8APhAQ9NwiLmHCeSAALrejiSC6X
         TzvyGo1G/XQKh9+P4u4XU2IWz0uiDRF+ohdZP64KVpgiP2AQL/dhquCh0lkrSP7/dXBm
         Aq/GvkglY9mO1NUjmHuBXReo3LJmgTd9kVSt00kPQjy581hAFlcV6Cl/t1N+KJHkt9Sa
         0EnA==
X-Gm-Message-State: AJcUukfDSoMs0NbuY2IQGnwPWVsyr9ru4HpPCv3hLt3AGipt+hJnmhPR
        AakVwPPDdPCCjznRMvIgvceK3HTNCGyT1s+fbXE=
X-Google-Smtp-Source: ALg8bN6asg4ACjm+I/qsuDyaEhCsFPFZT3hyb5lBBFPcZSESc56cWvPZ3LwnZlXIyw14QmlSLeYw6oo2vkz5P2NUX+o=
X-Received: by 2002:a19:c396:: with SMTP id t144mr838044lff.110.1546948425677;
 Tue, 08 Jan 2019 03:53:45 -0800 (PST)
MIME-Version: 1.0
References: <20181106120544.GA3783@jordon-HP-15-Notebook-PC>
 <20181115014737.GA2353@rapoport-lnx> <CAFqt6zbOgSm9omt+6iV0GJtZdZ_qyTr9Jte9ZGYRQ1M4CdB-mA@mail.gmail.com>
 <CAFqt6zZ67tFA8FjFZ4xM+YUAez9EdPHinx0ky0X5sQHyZ9nkLg@mail.gmail.com>
 <CAFqt6zYY=xfqvVxRi1spbMNzvoM_CYNxbm6d7_79a5bBHxUzuA@mail.gmail.com> <20190107144411.b3e2313649f106de0776432e@linux-foundation.org>
In-Reply-To: <20190107144411.b3e2313649f106de0776432e@linux-foundation.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 8 Jan 2019 17:23:33 +0530
Message-ID: <CAFqt6zZV-9qJYbKDbCNR1AkmeCVFWrJ2i270=w0i3jNEnN_nvw@mail.gmail.com>
Subject: Re: [PATCH v3] mm: Create the new vm_fault_t type
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     rppt@linux.ibm.com, Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        vbabka@suse.cz, riel@redhat.com, Linux-MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 4:14 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 7 Jan 2019 11:47:12 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> > > Do I need to make any further improvement for this patch ?
> >
> > If no further comment, can we get this patch in queue for 5.0-rcX ?
>
> I stopped paying attention a while ago, sorry.
>
> Please resend everything which you believe is ready to go.

Sure, I will resend. no prob :)
