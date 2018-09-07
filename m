Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64D6C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E81720844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z2cr6syi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E81720844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbeIGFbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:31:32 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:41022 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbeIGFbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:31:31 -0400
Received: by mail-wr1-f42.google.com with SMTP id z96-v6so13192440wrb.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 17:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rd6eALKTNqqfQLHfhhe4ckDvE/jeVYQ61VcErCB4W5A=;
        b=Z2cr6syi3jzioa2siVXqCOV4rf8nB+yT/dZqG6Ur58XOBojUWvTF19SoMxLQ93Clk9
         NTh1pdRvbh6r8ez59DL+xUDdmrWs7j23yg5gHEdELItNqjUm6qz6D3wFsgblg0ybB/Y3
         XKxmYn7BLKFkNABLM8/3yxbW0DVJ5l+laKoyzT3piKBIWmQItGFiSYZS/djl7jOInm7H
         LZ0q8yM4bGQITQG96ymgPI4f533uCo7eCF64pRqxqrvOZA0I+M3zfDS5JnOnPFXF12t6
         qecN8baeuI8hgotnI3e0uv+Vp00xwbU16lk7fv3zlhUB0sxzgsY+IeqJlRZtdvdQUVa7
         W7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rd6eALKTNqqfQLHfhhe4ckDvE/jeVYQ61VcErCB4W5A=;
        b=Xi2QJNvo87Nvz3KFQ/qV4gNYIjQObPermeuCXe/pQRky4kfiOdsJF8rmgNWKsLYAZ+
         fBq7yZSnQFsEoH6Zf6hAVQUxreOR952vTin4/2ZGNX3qhQFC6K6M0DsLbCI593ymHKsC
         IbVSXNR4E6zUDG8BJOtGD68NDkTlSkZ8+oNcB6BHuDTghplphWXG80KJE5756iDPEMOc
         iwb8FN9/rJVwrvmXuubPTUZ60jggdhpM4WmuvPKE0wB7z6VJAHp3Dzd6pMDKXJMtWw6H
         IniolcBTY7Q0MWNMuLdKSYZrMfxxxWdCDsbRWfCK+5fy5//24ND1I5Q+NTQG7d5TQI6V
         bdVQ==
X-Gm-Message-State: APzg51DGc+1N+VLyVgtsKKw0MfPiCDx/Rlp7vaxCSO/mloDFqmsyAd3W
        g7sdKST3nyHVBI8yA89V4eR6aRzVrXwXYpTVTkN4zA==
X-Google-Smtp-Source: ANB0VdZX+7iFtsp9sNXLTIsnlvgQ48UKyd6p785fYgERn3UVbONzOQIhT5UU/qhE7jyhZAWRMKDRus7OX0/s4lNS5Pc=
X-Received: by 2002:a5d:61c1:: with SMTP id q1-v6mr4502340wrv.33.1536281599858;
 Thu, 06 Sep 2018 17:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <1dc80ff6-f53f-ae89-be29-3408bf7d69cc@oracle.com>
 <01000165aa490dc9-64abf872-afd1-4a81-a46d-a50d0131de93-000000@email.amazonses.com>
 <877ejzqtdy.fsf@yhuang-dev.intel.com> <bd6f6f8b-4880-6c20-62f5-bb6ca3b5e6f7@oracle.com>
In-Reply-To: <bd6f6f8b-4880-6c20-62f5-bb6ca3b5e6f7@oracle.com>
From:   Hugh Dickins <hughd@google.com>
Date:   Thu, 6 Sep 2018 17:52:53 -0700
Message-ID: <CANsGZ6bW0vJcRpnfAesH-9_9vnrrvMHYH-UjH50zqLtA4WALyg@mail.gmail.com>
Subject: Re: Plumbers 2018 - Performance and Scalability Microconference
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Christoph Lameter <cl@linux.com>, daniel.m.jordan@oracle.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, aaron.lu@intel.com,
        alex.kogan@oracle.com, Andrew Morton <akpm@linux-foundation.org>,
        boqun.feng@gmail.com, brouer@redhat.com,
        Davidlohr Bueso <dave@stgolabs.net>, dave.dice@oracle.com,
        dhaval.giani@oracle.com, ktkhai@virtuozzo.com,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        Pavel.Tatashin@microsoft.com,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        shady.issa@oracle.com, tariqt@mellanox.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, longman@redhat.com,
        Yang Shi <yang.shi@linux.alibaba.com>, shy828301@gmail.com,
        subhra.mazumdar@oracle.com,
        Steven Sistare <steven.sistare@oracle.com>,
        Jonathan Adams <jwadams@google.com>,
        Ashwin Chaugule <ashwinch@google.com>,
        Salman Qazi <sqazi@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michel Lespinasse <walken@google.com>,
        David Rientjes <rientjes@google.com>,
        Junaid Shahid <junaids@google.com>,
        Neha Agarwal <nehaagarwal@google.com>,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 2:36 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 09/05/2018 06:58 PM, Huang, Ying wrote:
> > Hi, Christopher,
> >
> > Christopher Lameter <cl@linux.com> writes:
> >
> >> On Tue, 4 Sep 2018, Daniel Jordan wrote:
> >>
> >>>  - Promoting huge page usage:  With memory sizes becoming ever larger, huge
> >>> pages are becoming more and more important to reduce TLB misses and the
> >>> overhead of memory management itself--that is, to make the system scalable
> >>> with the memory size.  But there are still some remaining gaps that prevent
> >>> huge pages from being deployed in some situations, such as huge page
> >>> allocation latency and memory fragmentation.
> >>
> >> You forgot the major issue that huge pages in the page cache are not
> >> supported and thus we have performance issues with fast NVME drives that
> >> are now able to do 3Gbytes per sec that are only possible to reach with
> >> directio and huge pages.
> >
> > Yes.  That is an important gap for huge page.  Although we have huge
> > page cache support for tmpfs, we lacks that for normal file systems.
> >
> >> IMHO the huge page issue is just the reflection of a certain hardware
> >> manufacturer inflicting pain for over a decade on its poor users by not
> >> supporting larger base page sizes than 4k. No such workarounds needed on
> >> platforms that support large sizes. Things just zoom along without
> >> contortions necessary to deal with huge pages etc.
> >>
> >> Can we come up with a 2M base page VM or something? We have possible
> >> memory sizes of a couple TB now. That should give us a million or so 2M
> >> pages to work with.
> >
> > That sounds a good idea.  Don't know whether someone has tried this.
>
> IIRC, Hugh Dickins and some others at Google tried going down this path.
> There was a brief discussion at LSF/MM.  It is something I too would like
> to explore in my spare time.

Almost: I never tried that path myself, but mentioned that Greg Thelen had.

Hugh
