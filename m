Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752635AbeFEWSk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 18:18:40 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41597 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752396AbeFEWSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 18:18:37 -0400
X-Google-Smtp-Source: ADUXVKKqloP2YJhNZZNJNuOKaqpbQbuK4QN6KDWYx5Ld4SccYKAAhNZzgy6xRRnWFWRvQFGuncy4Uwl3iupcIfdpXow=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <1528208105.3237.155.camel@linux.vnet.ibm.com>
References: <20180604205455.2325754-1-stefanb@linux.vnet.ibm.com>
 <20180604205455.2325754-5-stefanb@linux.vnet.ibm.com> <CAHC9VhRkkQ74tvqGrSuNX2RdeHz5N7eU03-yHmVsZg47TxFD0g@mail.gmail.com>
 <1528208105.3237.155.camel@linux.vnet.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 5 Jun 2018 18:18:34 -0400
Message-ID: <CAHC9VhSbdYOkcszy+emgPNWWtUc0LoWy8pPvov+qjubV7b_EjQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] ima: Differentiate auditing policy rules from
 "audit" actions
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        sgrubb@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 10:15 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> Hi Paul,
>
> On Mon, 2018-06-04 at 20:21 -0400, Paul Moore wrote:
>> On Mon, Jun 4, 2018 at 4:54 PM, Stefan Berger
>> <stefanb@linux.vnet.ibm.com> wrote:
>> > The AUDIT_INTEGRITY_RULE is used for auditing IMA policy rules and
>> > the IMA "audit" policy action.  This patch defines
>> > AUDIT_INTEGRITY_POLICY_RULE to reflect the IMA policy rules.
>> >
>> > Since we defined a new message type we can now also pass the
>> > audit_context and get an associated SYSCALL record. This now produces
>> > the following records when parsing IMA policy's rules:
>>
>> Aaand now I see you included the current->audit_context pointer I
>> mentioned in my comments for 3/4 ;)
>>
>> So basically this should be fine, although I should point out that you
>> do not need to define a new message type to associate records
>> together.  The fact that we don't associate all connected records is
>> basically a bug.
>>
>> Anyway, patches 3/4 and 4/4 look good to me.  Considering this is
>> likely going in during the *next* merge window, I would ask that you
>> convert from "current->audit_context" to "audit_context()" as soon as
>> this merge window closes.
>>
>> Thanks!
>
> Thanks, Paul.  I'd like to start queueing patches for the next open
> window now, instead of scrambling later.  Can I add your Ack now, and
> remember to make this change when rebasing?

Sure, go ahead and add my ACK to both 3/4 and 4/4 as long as you
double pinky swear you'll do the audit_context() fix-up during the
merge :)

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
