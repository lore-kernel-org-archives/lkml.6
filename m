Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB4DC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8054B20864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b9Y/Gjgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8054B20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbeLCX0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:26:39 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36906 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLCX0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:26:38 -0500
Received: by mail-ot1-f68.google.com with SMTP id 40so13394727oth.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 15:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HPS2HFveSPDzLkXedVMY/WyPYO5TsRnFR1ztGmJoubY=;
        b=b9Y/GjgqcB71FPRQ+UFQG9Lu7l/1X/K/VsaWQscvhEg8e0cNVX4CPb4WJajOd11IKK
         z1RwvlhOAx0LzzdRieVC/5CrVolRpN8T3KKFP3YuxTm+jC4bV/leQWofeuhXipsR9Ya4
         lbEV7J+r0K7hWGNK94XRAEIfYqtOc9U0U5v0YuKkgQLe/DqQj241bmTmxb4tDFzUV7Ij
         MtuAElgJvoRTGhB2SHoCYmHMoepmSjcKB44vFVS1gIPhwsGMiMTRJetyQV+rowEELKUj
         3vjffL0Tik/fTX0IrsSQIZV0ZP+j3UdG86dze+//Evv2G/0z7X++E5EE88noTtKwaXR+
         hm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HPS2HFveSPDzLkXedVMY/WyPYO5TsRnFR1ztGmJoubY=;
        b=HuUrp4m/kMCXjb6zjQjfHsfO6QdR2u1jRTVomIHvSc+rWJrqt8Nw19j8262YaLRoPC
         XnjohjjB+/VUIvlJCSRVPmytB7CwxpVcve4CiT09D6qm/gMNcv8mZUTr/LrwDzI21qFp
         f1kQpo1IIohSGnwa95T+GvpKvQYWbyjoOSpEgVXAIUS/dMK1nyxdmv6PEjNfuGvzmMZD
         5IT3UK9/RDTbjv5yDE7VIhsyoccm9fEkuDzTF7rxlI7eBcgp6L7iTL5Ij/4+cCF4Ls+p
         89XfPpx/eH+sGw2FwCH2dh4a7jZRPBJDVtzhYV+0LMEZtm5IQPVI6Qlw8Se5w6zr7RKS
         mAtQ==
X-Gm-Message-State: AA+aEWb4IPO9MsjKUMLoK60rlxf5vCaksaRyeswVvDdF0zVZ1h+yVbon
        vnDZ65jbsWQzkgHLWUeZGQE0Te4InEc0sMcMPqxyCw==
X-Google-Smtp-Source: AFSGD/UQclCi88c4TOT7Y2CmQIXzN1APZo0zyYj87zPNNG/3LUk5Xu5ODNkxg5mxa0DDLX/hYL9X9sEZ+7JgiGrkov8=
X-Received: by 2002:a9d:65c8:: with SMTP id z8mr11589524oth.338.1543879597209;
 Mon, 03 Dec 2018 15:26:37 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-8-brendanhiggins@google.com> <20181130034001.GM18410@garbanzo.do-not-panic.com>
In-Reply-To: <20181130034001.GM18410@garbanzo.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 3 Dec 2018 15:26:26 -0800
Message-ID: <CAFd5g47CJnfE3Gqc03onidd5FiZSW43-6_dA5czb30-Rb3dyfg@mail.gmail.com>
Subject: Re: [RFC v3 07/19] kunit: test: add initial tests
To:     mcgrof@kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com,
        Frank Rowand <frowand.list@gmail.com>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 7:40 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Nov 28, 2018 at 11:36:24AM -0800, Brendan Higgins wrote:
> > Add a test for string stream along with a simpler example.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  kunit/Kconfig              | 12 ++++++
> >  kunit/Makefile             |  4 ++
> >  kunit/example-test.c       | 88 ++++++++++++++++++++++++++++++++++++++
>
> BTW if you need another more concrete but very simple example I think it
> may be possible to port tools/testing/selftests/sysctl/sysctl.sh +
> lib/test_sysctl.c into a kunit test. Correct me if I'm wrong.

I think that is pretty doable. I don't know that I want to shoot for
that on the next revision. But I can definitely do it in a later
revision, or a later patchset, unless you would strongly prefer it
now, that is.

>
> I think that would show the differences clearly between selftests and
> kunit as well.

True. Maybe a good thing to shoot for once the DT tests are in order?
