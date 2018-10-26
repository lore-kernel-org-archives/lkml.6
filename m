Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A27ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691F120848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691F120848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbeJ0Cju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:39:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34566 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbeJ0Cju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:39:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id g12-v6so898468pgs.1;
        Fri, 26 Oct 2018 11:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eHviPpv7+j5qRDTSOOy8MXYE5rSu+toB03hnYLx8TFY=;
        b=boxZfh+fgV3tmRMoDZRgnlILYqZKV9g0mkx7l4DXgzE87s8LdRkRZOhgK58FoUHyrt
         cnLEsahuiZ8uxV/hTtF4hgjcD3hQGiecFXkNojl9y20Cyc1ZlYlVKkjQQViNfVsd1uAz
         AZ4zoz8kSzBHiZxH7G0V9KK4MMRYyXDfQ9KjfsBDb9h1bOcFDUP13+If83BC642zXjhu
         aeztbo4GCg9qLEWZCjuPLCBQK1KxZ5V1o6qZ5Xm6Kkj9hpQPgapSk4sps4VUaVbKO748
         AvysKIYQ64IphlPTYQp+7ChRHmTYGpkmhUtZxLGG0Ye0mMYnhXrRwdTnj3UFilga6vXq
         4KIw==
X-Gm-Message-State: AGRZ1gLfTWjAFiFvkFSoESwlBhTaUBfHMR7JRU7WUeAkCiqI3GTun/Ec
        XFX8SbFes0loeH97KwGLzDM=
X-Google-Smtp-Source: AJdET5fdpdTBpiBkpaEOqBtnOuFpNNKfPG/jK9LN4rGTbmQ4xkLEV7z/y5XqyQ9XmwQih4KrWWPUAw==
X-Received: by 2002:a62:3384:: with SMTP id z126-v6mr4823139pfz.112.1540576910886;
        Fri, 26 Oct 2018 11:01:50 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id d2-v6sm12845007pfn.118.2018.10.26.11.01.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 11:01:49 -0700 (PDT)
Message-ID: <1540576908.66186.103.camel@acm.org>
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
From:   Bart Van Assche <bvanassche@acm.org>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     ooo@electrozaur.com,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        hch@infradead.org
Date:   Fri, 26 Oct 2018 11:01:48 -0700
In-Reply-To: <CAKwvOdnwmf47_m_0K5OCLmXbrkLNnekpNOPCCMeJqkuqKUbQ-A@mail.gmail.com>
References: <20180930205448.26205-1-natechancellor@gmail.com>
         <10b12992-3570-4646-374b-82cbd7276839@acm.org>
         <CAKwvOd=wgxB69dMxzMeH2edCn=TdQGPGkNVW1e=QHPTJtO9ZNw@mail.gmail.com>
         <1538503063.193396.6.camel@acm.org>
         <CAKwvOdmsNEexQL9R8rgcRcXTZButYM6YWwG8bhVWCoJ8bOqCrA@mail.gmail.com>
         <1538521591.193396.8.camel@acm.org> <20181025213144.GB24709@flashbox>
         <CAKwvOdn=TvoGdFvgxX6TyXBXnhVLttriRrZEnzS6DjcjL64DPA@mail.gmail.com>
         <20181025225548.GA10326@flashbox>
         <CAKwvOdnwmf47_m_0K5OCLmXbrkLNnekpNOPCCMeJqkuqKUbQ-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-10-26 at 10:54 -0700, Nick Desaulniers wrote:
+AD4 If creating one instance of this variable is a functional change, I
+AD4 can't help but suspect the original code was wrong.  But maybe Bart,
+AD4 Boaz, or Christoph can clarify or have more thoughts on this?  Looks
+AD4 like Boaz added this header in commit de258bf5e638 (+ACIAWw-SCSI+AF0 libosd:
+AD4 OSDv1 Headers+ACI).

Hi Nick and Nathan,

Had you noticed the following e-mail from early October:
https://marc.info/?l+AD0-linux-kernel+ACY-m+AD0-153849955503249?

Thanks,

Bart.
