Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752581AbeDEJ4M (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 05:56:12 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:45576 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752340AbeDEJ4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 05:56:09 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 181D8332C25
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Thu, 05 Apr 2018 11:56:06 +0200
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Kees Cook <keescook@chromium.org>
Cc: David Windsor <dave@nullcore.net>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        keescook@google.com
Subject: Re: usercopy whitelist woe in scsi_sense_cache
In-Reply-To: <CAGXu5jL++CEmLzFtGMVMhGWBzHpsRNJPTsEoc7Pw1dP--=azCA@mail.gmail.com>
References: <10360653.ov98egbaqx@natalenko.name>
 <CAGXu5jLwyot++C2EXs+032Lz5WdG65GsEJ-Q55rfhSbkG1Nh+A@mail.gmail.com>
 <3265889.eu5sbW8aRz@natalenko.name>
 <CAGXu5jL++CEmLzFtGMVMhGWBzHpsRNJPTsEoc7Pw1dP--=azCA@mail.gmail.com>
Message-ID: <7fc01f67a561ce1fad676fc34c2249e7@natalenko.name>
User-Agent: Roundcube Webmail/1.3.5
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1522922167;
        h=from:sender:reply-to:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:resent-to:resent-cc:resent-from:resent-sender:resent-message-id:in-reply-to:references:list-id:list-owner:list-unsubscribe:list-subscribe:list-post;
        bh=OV1epDubZ+9Lc43VMkVpI5D/dy9BWeKrxhnkiUGGczY=;
        b=1TmiuD7XqTFS3cuDBBsiPSmf16WzCV9xdPPEFAze+3+XCC5ARHBSEMFtlqU/oQJCdP+gZi
        6yCKztmOAWMy1AI6DfyWp9JX7XXX3wx/KGJ+ApV4AwigCYI20jCdC2Pzk7TwpjADCc4Z0z
        JwMOvEsUwB2MfnxDxu3Qkd0438QTYSg=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1522922167; a=rsa-sha256;
        cv=none;
        b=GV0Sg76N/NkKxfgwcKT+iE6veRLbffT0/vZeLxeq2p9eEoxpfHl0EBypqAtABo6CEX9iTAT22mGMnJ0Up3gqreEu0iq85ryE4dztNSZYZNg4i1nLEITlkqWbjXz9Rnj90+ZDfxxdMEKUL6GmEhmhCkEi9ke4ParXBvR3ny1KQqM=
ARC-Authentication-Results: i=1; auth=pass smtp.auth=oleksandr@natalenko.name
        smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

04.04.2018 23:25, Kees Cook wrote:
> Thanks for the report! I hope someone more familiar with sg_io() can
> help explain the changing buffer offset... :P

Also, FYI, I kept the server running with smartctl periodically invoked, 
and it was still triggering BUGs, however, I consider them to be more or 
less harmless until the server got stuck with high I/O wait this morning 
after next smartctl invocation. So, it isn't harmless, it seems…

It could be unrelated, of course, since the journal didn't give me any 
hint (or a stack trace) on what happened, thus I'll monitor how things 
behave without smartctl too.

Regards,
   Oleksandr
