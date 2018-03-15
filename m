Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751951AbeCOKh3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 06:37:29 -0400
Received: from mail-ot0-f169.google.com ([74.125.82.169]:43572 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751481AbeCOKh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 06:37:27 -0400
X-Google-Smtp-Source: AG47ELuA0+Bt2WaHC7SrNEk1fZyNZJ7bZr2rK7XYm+ZaR1eOUtOmvNAHZ0qf2E0S5iwCEfM6RWyxXg==
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] scsi: iscsi_tcp: set BDI_CAP_STABLE_WRITES when data digest enabled
From: Lee Duncan <leeman.duncan@gmail.com>
X-Mailer: iPhone Mail (15D100)
In-Reply-To: <yq137129dvi.fsf@oracle.com>
Date: Thu, 15 Mar 2018 04:37:24 -0600
Cc: lduncan@suse.com, cleech@redhat.com,
        Jianchao Wang <jianchao.w.wang@oracle.com>, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <8FA9AB3F-DFD0-4DB9-B1F3-0C1049E4A2E5@gmail.com>
References: <1520425743-1923-1-git-send-email-jianchao.w.wang@oracle.com> <yq137129dvi.fsf@oracle.com>
To: open-iscsi@googlegroups.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2FAbX5A022503

I reviewed this several days before but mistakenly replied only to the open-iscsi list. 

Signed-off-by: Lee Duncan <lduncan@suse.com>

--
Lee-Man Duncan
Sent from my iPhone, dude


> On Mar 14, 2018, at 10:11 PM, Martin K. Petersen <martin.petersen@oracle.com> wrote:
> 
> 
>> iscsi tcp will first send out data, then calculate and send data
>> digest. If we don't have BDI_CAP_STABLE_WRITES, the page cache will
>> be written in spite of the on going writeback. Consequently, wrong
>> digest will be got and sent to target.
>> 
>> To fix this, set BDI_CAP_STABLE_WRITES when data digest is enabled
>> in iscsi_tcp .slave_configure callback.
> 
> Lee, Chris: Please review!
> 
> -- 
> Martin K. Petersen    Oracle Linux Engineering
> 
> -- 
> You received this message because you are subscribed to a topic in the Google Groups "open-iscsi" group.
> To unsubscribe from this topic, visit https://groups.google.com/d/topic/open-iscsi/owLIZAXfgoA/unsubscribe.
> To unsubscribe from this group and all its topics, send an email to open-iscsi+unsubscribe@googlegroups.com.
> To post to this group, send email to open-iscsi@googlegroups.com.
> Visit this group at https://groups.google.com/group/open-iscsi.
> For more options, visit https://groups.google.com/d/optout.
