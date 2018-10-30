Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAA4C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C762082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="JFD1xXFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C762082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeJ3Prj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 11:47:39 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43079 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbeJ3Prj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 11:47:39 -0400
Received: by mail-ot1-f68.google.com with SMTP id k9so10062468otl.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 23:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2oEctViFWGv5eMUDxpWzydSoGJaeA2ZN4aB61tX/MeE=;
        b=JFD1xXFBNKZ6cX0yIR1rE38RC1OfSF80xEszztaMuH0K5TsxAsdg/CnuAiSKwhdrXE
         QemGK8CIzrR62rXk9yZTPz2O2B618r/9VujQfAwmvCRYaS0MvLwVk2f1AVORD4LrEdgT
         ubmbjXIBPTymxE1Thw6PpXWKRh0ZXR3Db0HgB/Ws3OohN/88FBqsI0KGIp49QGp+1/Pw
         ko7ekHYdIPQVOQ1PJ2jvlLdhkNccyw/OROPfA4P9dMtykWhjB5VyMnCFtgj+wQ0hngf5
         MC67ImwrQBNtS3W9zV2N6m5kSCtkmGpHT9a8lQlI/69ZK8XCfQWR6ECUMKy5WtXQu3Rh
         0LDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2oEctViFWGv5eMUDxpWzydSoGJaeA2ZN4aB61tX/MeE=;
        b=TIMOxuAAbFmvLDAKJMbWtF6DB3UzmzGMlYhL/TsCtkxUHlwX5cia6TP1Y2ordQxvtg
         Y903EDUY1Us9ywEtA5G0sJaP+lhvmQNr2AAlHZomIvcWkFKyjWhOwGyHiE1Pq+O+9q+x
         lOhiZMRpyjOD06uX+QuwQsrYPewcjWEvZ9yUmCZfcAHpYFrX81qbIfU0S5gXkcLq1Yyq
         RVYXq/jL2yeKzxT3R8O8SxSZ7K9fYvOvZuyZ1c5lUm1811cdt4YlOxSdrzwZ33R4K7mF
         6Q6TFSMLSFkI+zXvq6og6z/jDlxdcUut4Jo92DBoQlf9bzJ7cn8oTq3yhcZo2ZBiBm9J
         PgXQ==
X-Gm-Message-State: AGRZ1gJQ2mdUoLotoeCb16NT7rvXnIt7AkST0SAfzTiZto5wZPHSaZDv
        c/u1R/KWhFusDIos2UsnLWeVhi9Gluykm8MQ2gdy9w==
X-Google-Smtp-Source: AJdET5fmAwhaaAEwjDGPAX8c80uO4K5Ehg60sOXBIIWA/M1/OGmUGA4ZUzbcHplkaDDFlyNfi1PV92LIWJ21dHmSkEo=
X-Received: by 2002:a9d:9c4:: with SMTP id 4mr5421953otz.214.1540882523764;
 Mon, 29 Oct 2018 23:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20181017075257.GF18839@dhcp22.suse.cz> <971729e6-bcfe-a386-361b-d662951e69a7@linux.intel.com>
 <20181029141210.GJ32673@dhcp22.suse.cz> <84f09883c16608ddd2ba88103f43ec6a1c649e97.camel@linux.intel.com>
 <20181029163528.GL32673@dhcp22.suse.cz> <18dfc5a0db11650ff31433311da32c95e19944d9.camel@linux.intel.com>
 <20181029172415.GM32673@dhcp22.suse.cz> <8e7a4311a240b241822945c0bb4095c9ffe5a14d.camel@linux.intel.com>
 <20181029181827.GO32673@dhcp22.suse.cz> <3281f3044fa231bbc1b02d5c5efca3502a0d05a8.camel@linux.intel.com>
 <20181030062915.GT32673@dhcp22.suse.cz>
In-Reply-To: <20181030062915.GT32673@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 29 Oct 2018 23:55:12 -0700
Message-ID: <CAPcyv4itSde5oiW2j5uK8PCqdpXkHKz=kS8NBk2Ge+Ldb=yLUg@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
To:     Michal Hocko <mhocko@kernel.org>
Cc:     alexander.h.duyck@linux.intel.com, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Dave Hansen <dave.hansen@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        rppt@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>,
        osalvador@techadventures.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 11:29 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 29-10-18 12:59:11, Alexander Duyck wrote:
> > On Mon, 2018-10-29 at 19:18 +0100, Michal Hocko wrote:
[..]
> > The patches Andrew pushed addressed the immediate issue so that now
> > systems with nvdimm/DAX memory can at least initialize quick enough
> > that systemd doesn't refuse to mount the root file system due to a
> > timeout.
>
> This is about the first time you actually mention that. I have re-read
> the cover letter and all changelogs of patches in this serious. Unless I
> have missed something there is nothing about real users hitting issues
> out there. nvdimm is still considered a toy because there is no real HW
> users can play with.

Yes, you have missed something, because that's incorrect. There's been
public articles about these parts sampling since May.

    https://www.anandtech.com/show/12828/intel-launches-optane-dimms-up-to-512gb-apache-pass-is-here

That testing identified this initialization performance problem and
thankfully got it addressed in time for the current merge window.
