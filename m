Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A390C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D22206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D22206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeKPKrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:47:48 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38734 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbeKPKrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 05:47:47 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so249275plb.5;
        Thu, 15 Nov 2018 16:37:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZxbAZJudGfrOkmxoaoZEDr2jGaqtOT9nKvG5oiQM5n0=;
        b=c8CdoRHw7cTItrfj7iEq8m24I2dTgEOLHRS3a/I8oQr/JBEu86rilnrTFgMVkb4OYu
         dI9SQRJaoO9FhEuepayxogZVoWqXKzoMGTeaSNIZxBz4rxd6JSlNjutqxBt4CR7QQcti
         acwHtUgTuY0IiZUJlvZ9AuSyaSO13W0BHEk0sV2MMQzZrJPci2nDcPhJIm92hR5o5d+v
         Cn5tkfWWnsR3QRMYHjC8Em9J8I1pDwh6Duz49EudfYSLZun/Qw03YYtVcNCulkp8aX1I
         6tfWWQ1UVoqvrwSlKv/UgEeBV6s2a06KdA0b+u7VCvOaeinxKO+MWM42x2x9LMU+jT0n
         tRfg==
X-Gm-Message-State: AGRZ1gLdY1N74BwLjWTupf3aF6U+GIH9x8qv4ja9YvANF3ljyGmmgddi
        W3q9OeFkICYIt6IehwRGymc=
X-Google-Smtp-Source: AJdET5dWXmZ++lbR97YTzNewPCEa950g+08lGxfpufZRm0Q8ohc6lc/c7PvdcXzauO1micdfKt7U3g==
X-Received: by 2002:a17:902:887:: with SMTP id 7-v6mr8628718pll.283.1542328656690;
        Thu, 15 Nov 2018 16:37:36 -0800 (PST)
Received: from [172.30.51.210] ([64.114.255.97])
        by smtp.gmail.com with ESMTPSA id e126-v6sm19471007pfe.67.2018.11.15.16.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 16:37:36 -0800 (PST)
Message-ID: <1542328654.100259.18.camel@acm.org>
Subject: Re: [PATCH 0/3] SG_IO command filtering via sysfs
From:   Bart Van Assche <bvanassche@acm.org>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@infradead.org>
Date:   Thu, 15 Nov 2018 16:37:34 -0800
In-Reply-To: <98fe5cf7-722a-37d6-156d-842e8812e430@redhat.com>
References: <1541867733-7836-1-git-send-email-pbonzini@redhat.com>
         <20181110190521.GA2627@thunk.org>
         <566bc821-f12a-f7c1-e7c7-99092807ee27@redhat.com>
         <20181111141426.GA7377@thunk.org>
         <98fe5cf7-722a-37d6-156d-842e8812e430@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-16 at 01:26 +-0100, Paolo Bonzini wrote:
+AD4 Yeah, and there are even already helpers such as
+AD4 bpf+AF8-get+AF8-current+AF8-uid+AF8-gid.  So that part can be done in a sort-of generic way.
+AD4 
+AD4 I can try and do the work, but I'd like some agreement on the design
+AD4 first...  For example a more important question is how would the BPF
+AD4 filter be attached?  Two possibilities that come to mind are:
+AD4 
+AD4 - add it to the /dev/sg+ACo or /dev/sd+ACo struct file(+ACo) via a ioctl, and use
+AD4 pass the file descriptor to the unprivileged QEMU after setting up the
+AD4 BPF filter, via either fork() or SCM+AF8-RIGHTS.  This would be a very nice
+AD4 model for privilege separation, but I'm afraid it would not work for
+AD4 your use case
+AD4 
+AD4 - add BPF programs to cgroups, in the form of a new
+AD4 BPF+AF8-PROG+AF8-TYPE+AF8-CGROUP+AF8-CDB+AF8-FILTER or something like that.  That would also
+AD4 work for my usecase, and it seems to be in line with how the network
+AD4 guys are doing things.  So it would seem like the way to go.
+AD4 
+AD4 Some other details...  Registering the first cgroup-based filter would
+AD4 disable the default filter+ADs if multiple filters are attached, the
+AD4 outcomes of all filters would be AND-ed, also similarly to how socket
+AD4 and sockaddr cgroup BPF works.  Finally, filters would be applied also
+AD4 to processes with CAP+AF8-SYS+AF8-RAWIO, unlike the current filter.
+AD4 
+AD4 Needless to say, this would not add special case code, but it would
+AD4 still add a substantial amount of code, probably comparable to this series.

All user space interfaces in the Linux kernel for storage that I'm familiar
with not only allow configuration of parameters but also make it easy to
query which parameters have been configured. The existing sysfs and configfs
interfaces demonstrate this. Using BPF to configure SG/IO access has a
significant disadvantage, namely that it is very hard to figure out what has
been configured. Figuring out what has been configured namely requires
disassembling BPF. I'm not sure anyone will be enthusiast about this.

Bart.

