Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD040C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD3D2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkYousv+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD3D2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbeKBXFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 19:05:16 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46478 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeKBXFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 19:05:16 -0400
Received: by mail-lj1-f195.google.com with SMTP id x3-v6so1802229lji.13;
        Fri, 02 Nov 2018 06:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GIYGs1awsUjJ9znl2+T06zK12dFqeBUANFZNWFROQ0M=;
        b=BkYousv+pvbF7m75fDEMvgWBuVi24UWl5OjK548z6yoGYQfTp7oJVgHHGSm9hA/OVU
         ozFCcLQLXQa4Vb/N8jbnr3idnLeypj66H+Hdw0rlSitCM4klCVzu5En8+AsipJZH3BQs
         vvCNMsKUoDBdmnkLHl9X0U8zwXw4tvMZdwEZ98Twtt3rrvlBW4UIHUWsTsqaVueUrPXN
         MlGwg/oWCpJ3GynlbtEEqPh904kDa+Ds4uHmTo3hHJfiqD4ofnQL3JINhUE9cabF3p9P
         t1HEHvhFka2MnpTLDcKttO4Pn8mTB4mdQLlpvzp5yHqLK9SExaCMbP+0LVJFzmUncM2o
         LizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GIYGs1awsUjJ9znl2+T06zK12dFqeBUANFZNWFROQ0M=;
        b=lI7U/N+5n+0U94QzpIbMOb/XR7mLTq9IT94m7w7tc0VeMfmZaswNzw++Xu08FmgabV
         kKUAbKQbGbuCadR+5D4wMF79j0KAMhDOiuw96J30ONNzZlX3grWn3nQbBJHF8F4OhRRR
         GUoY3BN/z4MI2SvqNdBMIO17jBLV57CkVJD0qKDRZaI6t21Yrn05gpNXJtsXR5f5w/mn
         cAhm3SitkVa7NIcErbTP9rpLuTOhjtmVMQvY9cGvU/Bmk1xYSUkIviwF5BA01mAM1wp4
         YLy0cMtO+QKLEXQ112/Xnt/IT6ByHzBd7JM7UNoNRm3U4lfdHz6cExNJFmn5A8OePUuH
         KeDg==
X-Gm-Message-State: AGRZ1gJZPt7X2IHFydUgrZSy2aCVfOb3y8O+CCbTRQ8WRqXvkQK5hmD6
        hZ9KrxhlY/g3hfoHmiFYGEyr7Q5UJZgCDRJGIKuNCZFr
X-Google-Smtp-Source: AJdET5fwpUnXsUrY35nM8UvhJcsDCk8oTj4SAKdipwtnfe7obQcYjI8ZqJsDVyqk3WQJ8oMsA8Rs1ueIQBI4CXBBVU8=
X-Received: by 2002:a2e:5109:: with SMTP id f9-v6mr7428365ljb.52.1541167080668;
 Fri, 02 Nov 2018 06:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20181102143018.09feb051@canb.auug.org.au> <CANiq72m65bQZefAoFF5dTUB-rPzm4vofZFnDn0nYBG3MsGrjZg@mail.gmail.com>
 <20181103002218.3bd015b3@canb.auug.org.au>
In-Reply-To: <20181103002218.3bd015b3@canb.auug.org.au>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 2 Nov 2018 14:57:48 +0100
Message-ID: <CANiq72=kHErmujzMgM4akXeoWkSR0Q3VLd-6Mwiaj5mGan8yZw@mail.gmail.com>
Subject: Re: linux-next: Tree for Nov 2
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 2:22 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Its always OK (and actually useful) to move your branch head up to
> where Linus merged it (this is usually a fast forward anyway) since
> that doesn't add any new code to linux-next to conflict with code that
> is still pending to be merged by Linus.
>
> Also, adding bug fixes is always fine.
>
> I just want to avoid getting conflicts in linux-next between code
> that Linus will merge during this merge window and new code destined
> for the next merge window.

Thanks Stephen! I assumed as much, but I doubted due to the warning
(and I wanted to avoid giving you an unexpected surprise tomorrow).

Cheers,
Miguel
