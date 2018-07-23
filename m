Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCE1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5932064D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Rzwj3/8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D5932064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388228AbeGWXSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 19:18:04 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:43058 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388199AbeGWXSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 19:18:03 -0400
Received: by mail-qt0-f178.google.com with SMTP id f18-v6so2270292qtp.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 15:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=KrkqEjJFOsHl+Iwy5c5qahdjQwUj6SbT9QwR396+5O4=;
        b=Rzwj3/8YxsgdqD/dJeXu4PMZ/fgiJmFdjsqWHpw/kA4j/21hccDT8reQhG4rHE0Mqb
         t1FlXURVf9Raw4KmkfE2K4x2gjUpB9AXD8IZ0Moqg4vKJokIXRlLjtNo2WtpP0zNgPCK
         anPAB2I845vatUXigmgwHH4I0eAaAwoPCPcoOjvwAQCuf0nsaczIUHN1cutHz9QS+sgH
         j0MNYK3j5DCF5mwqDILa6JzPsXi5L41GOO9Ae08143bArZyaF+ADu4YTBz7fz8hDZth6
         aHdLO7w8Q11rh/22JDEVYd9fAJgnVI+3HSdH8RR75o6U1u1ro4WtZJ6g5AqOlTxIcg9S
         qx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=KrkqEjJFOsHl+Iwy5c5qahdjQwUj6SbT9QwR396+5O4=;
        b=IL44mOBlBAcl3qZqiwQ5UxXVnVDHGhajuGJ9bLUxJURg0dSS0ylc9BtiDN4sW7RA4m
         sTaFsiFGjWiyE3WuTZIUPVxZzOYiST9uGnz2NaEnrbUi238zpz2ast+NALM9BbDWKmQ9
         vthdKB/eq+Y7DrC7YcsEYtd3/yQ7Rk/kQlswHAlRGM7VikYaiWfqZu9T4KFnwpbqqFGG
         mFibwy1geDBZ66caiP3zXL59IjcSyam9jjDIEg3MiuhY+4JvRfs/UD3zD+C0LRLYerOe
         gLbYT8sAkycblCkJ+7twkZ7JWU6oCo9s2XdnxVHS2CqGyiA55bWgMYF3t+psVk9W3sMs
         IAxg==
X-Gm-Message-State: AOUpUlFZpTuwF3FvSJUpbXLuwkT5Y3aWmYmQnza+Zvsxe2lD39hEXE3p
        rVcv9JVSzoKepSMkHCCj+EH15g==
X-Google-Smtp-Source: AAOMgpdcDo+UP+Du0/J6Cx1WHlRY6pE3ZS3XVP+4Wcx668kabqN5r+ROX6zMQxcHBOngcz5sJjvXSw==
X-Received: by 2002:a0c:f9c8:: with SMTP id j8-v6mr12938786qvo.177.1532384084575;
        Mon, 23 Jul 2018 15:14:44 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id r27-v6sm10832223qkr.17.2018.07.23.15.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 15:14:44 -0700 (PDT)
Date:   Mon, 23 Jul 2018 15:14:39 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Tal Gilboa <talgi@mellanox.com>
Cc:     Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "alex_gagniuc@dellteam.com" <alex_gagniuc@dellteam.com>,
        "austin_bolen@dell.com" <austin_bolen@dell.com>,
        "shyam_iyer@dell.com" <shyam_iyer@dell.com>,
        "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>,
        "ariel.elior@cavium.com" <ariel.elior@cavium.com>,
        "michael.chan@broadcom.com" <michael.chan@broadcom.com>,
        "ganeshgr@chelsio.com" <ganeshgr@chelsio.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "mike.marciniszyn@intel.com" <mike.marciniszyn@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] PCI: Check for PCIe downtraining conditions
Message-ID: <20180723151439.50524a2a@cakuba.netronome.com>
In-Reply-To: <b9a6b3b8-56cf-8bb5-2568-071ccd8a4f28@mellanox.com>
References: <20180718215359.GG128988@bhelgaas-glaptop.roam.corp.google.com>
        <20180723200339.23943-1-mr.nuke.me@gmail.com>
        <20180723140143.1a46902f@cakuba.netronome.com>
        <b9a6b3b8-56cf-8bb5-2568-071ccd8a4f28@mellanox.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018 00:52:22 +0300, Tal Gilboa wrote:
> On 7/24/2018 12:01 AM, Jakub Kicinski wrote:
> > On Mon, 23 Jul 2018 15:03:38 -0500, Alexandru Gagniuc wrote:  
> >> PCIe downtraining happens when both the device and PCIe port are
> >> capable of a larger bus width or higher speed than negotiated.
> >> Downtraining might be indicative of other problems in the system, and
> >> identifying this from userspace is neither intuitive, nor
> >> straightforward.
> >>
> >> The easiest way to detect this is with pcie_print_link_status(),
> >> since the bottleneck is usually the link that is downtrained. It's not
> >> a perfect solution, but it works extremely well in most cases.
> >>
> >> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> >> ---
> >>
> >> For the sake of review, I've created a __pcie_print_link_status() which
> >> takes a 'verbose' argument. If we agree want to go this route, and update
> >> the users of pcie_print_link_status(), I can split this up in two patches.
> >> I prefer just printing this information in the core functions, and letting
> >> drivers not have to worry about this. Though there seems to be strong for
> >> not going that route, so here it goes:  
> > 
> > FWIW the networking drivers print PCIe BW because sometimes the network
> > bandwidth is simply over-provisioned on multi port cards, e.g. 80Gbps
> > card on a x8 link.
> > 
> > Sorry to bike shed, but currently the networking cards print the info
> > during probe.  Would it make sense to move your message closer to probe
> > time?  Rather than when device is added.  If driver structure is
> > available, we could also consider adding a boolean to struct pci_driver
> > to indicate if driver wants the verbose message?  This way we avoid
> > duplicated prints.
> > 
> > I have no objection to current patch, it LGTM.  Just a thought.  
> 
> I don't see the reason for having two functions. What's the problem with 
> adding the verbose argument to the original function?

IMHO it's reasonable to keep the default parameter to what 90% of users
want by a means on a wrapper.  The non-verbose output is provided by
the core already for all devices.

What do you think of my proposal above Tal?  That would make the extra
wrapper unnecessary since the verbose parameter would be part of the
driver structure, and it would avoid the duplicated output.
