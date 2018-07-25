Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD729C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B3720843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kPzvYxwz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B3720843
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbeGYW2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:28:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39012 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731174AbeGYW2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:28:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id a11-v6so1363559pgw.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 14:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HROS7mRa5gg8Vf1v1spSDfTFfCguC1jOa2mEvzkuCms=;
        b=kPzvYxwz0ZEWVQQ/55CWO2gpgb3ZEoDh1gJ0YrG7O4HK2CtT3NiiLtQ0/MDzgvuw8K
         ElBM7ZM40mz36dJhMSg9H9zC/GKVT7SOk0J0G0SHYW49MQWodNTS4lBNmRALvn8G4Hl5
         NGJVmT4zasmnMHgDD69+ldSIFkuevz6wVUzf5OhHN5PQd77hacNEgTU0OgP4Bhy/+SkN
         jv22TOt4Jni2wqWLfrWWIEiQNf61TSZMuHPPEmsxOKQ0OO+UpmE0Rn+/kuEKbUmkanNn
         B80V86oBWqI95wg1ZV7OIor+DbXm3whNyRBLc2Huf5SDpcO1cVYu3iEjW9fIe+wxV1Xv
         j/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HROS7mRa5gg8Vf1v1spSDfTFfCguC1jOa2mEvzkuCms=;
        b=ARe7Ph8gvSsiqX8olnjulDskegjs2jWJmqZhFufikcETGAs45ufoOcX4UdIRaF0uUN
         MtGznUI0/CthPjDsBvi7UO5pro5/T3HMOImDmQOunCyHw649MRlRndGw4O8gSrA6EeRy
         F2fFB/wPxPvWjK6uY0gnC/ln6sOJZpxhDXwfLE71qfEGOYXykDHyf4LkstckvdKTPpLA
         REQH3cb+FwMpWZlrqSysGCUrwdMXJCg7m7Bvd2nxRHUsZ1xDYP0y2MkNdyksc7U7cVzt
         n4qvGwk9nKoNeZ6Eg+IrIhngDfa/XaFS5g35O3RAjUoDvZGf/L4aeCh2cvwwwGNAfSjr
         wVrA==
X-Gm-Message-State: AOUpUlGt65xaLiYturbv1sR0+mfEv02Aa3+1bW5rGHKR7RJW4dZLNooU
        P6xEbOD/jma5kV+9eXMOV+Qw2uIwdNXKHr6ZKYMQ2A==
X-Google-Smtp-Source: AAOMgpfDowQniwDULgQ68uid+RfWKAn7OVEgA7CwHmYXYu6mlCDTHX6xKx6nkanX1Qa3aAqtCC+VTQWScQ29cyZbLQA=
X-Received: by 2002:a63:195e:: with SMTP id 30-v6mr21826506pgz.192.1532553283414;
 Wed, 25 Jul 2018 14:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180725202238.165314-1-salyzyn@android.com>
In-Reply-To: <20180725202238.165314-1-salyzyn@android.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 25 Jul 2018 14:14:32 -0700
Message-ID: <CAKwvOdnmKBRS02205fVzrAOdKmd3s4KWaP9qtcTd6vW-Y3+Zgw@mail.gmail.com>
Subject: Re: [PATCH] tracing: do not leak kernel addresses
To:     salyzyn@android.com
Cc:     LKML <linux-kernel@vger.kernel.org>, rostedt@goodmis.org,
        mingo@redhat.com, kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 1:23 PM Mark Salyzyn <salyzyn@android.com> wrote:
>
> From: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
>

Thanks for sending.  You should take credit/authorship, and add my
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
