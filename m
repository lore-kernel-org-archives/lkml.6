Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F138C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107E421755
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxtefMSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107E421755
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbeHNAcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:32:25 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44368 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730027AbeHNAcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:32:24 -0400
Received: by mail-pl0-f68.google.com with SMTP id ba4-v6so7434302plb.11;
        Mon, 13 Aug 2018 14:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eRe8tHpKMfD0sR7WLtln0nbLoir1wj6/XRoyYOrGg0w=;
        b=IxtefMSDRRABKB/+BHoQ5XJS/mZN9w9nyK6MYrYl3S6JJhkwbXM4hkNTS3w40o+rUb
         QAogHgDJDiihfIZ19J97UWCnzmWj2WldpHsV+gaE2zppbJ3fg37llELGFaq8jSFMW3LO
         jRuYFZ2VHea9uPrD0bKXaFIgLP2YAR65Pw+jJDPovBMSybS9GSs4yuIND6/3k+UeZAGQ
         SRwxYodQ4FA2w0NmnOGAwp1rrmU6a5OlfkLyHwdSIJ3iXuf8N6sIQj/GqCqzw1/4wApJ
         2qYwCGlQxyU8swcdIs6DDIU9Ju7lVDpAbM/RjzK8uHRaeJ24Kxr/JwLuw9d+w1SpjRWS
         LbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eRe8tHpKMfD0sR7WLtln0nbLoir1wj6/XRoyYOrGg0w=;
        b=VVuB/0GPzmawXgOADlI+2avkvfcPyDdDpoirHJQxrBhsO5bpLLaPWPbtXPGmwxWXXP
         hoEvUYHaaaS6jne1fHQ9MbSAMf6F10ssAnQhPFa7iVkkUPnjqOcow7uumvXjvMqTkhwC
         2y9wyyuMiCowydfY7qBuoT6Ayo7R9Ob7p48dsc2B7lwTORbUzAdxto0VcAOz+FfbN3Hv
         wsmx2FOa+y3d89D8/33i7I+TsAG9lEMrqvt/KeGVJAoDKMRiDz9he5PAOzaNsHeFmpQd
         jfM1DzyRbov+ct8/vvWoWdaZO/+KPqYN7Ndxqloc7J7UJmfiPT7SesCAHRcs8wozm+4/
         nMBA==
X-Gm-Message-State: AOUpUlHdWuDxeSxyNyM8NAQWBtswqcHv34JkB6pYeM7KA5Oe0zObFSkE
        xWxugnEaRLg3ug28hrJ9H1j3U792
X-Google-Smtp-Source: AA+uWPxDrTYm1qqBuQkAwK8v+yQzE/S7dXPppjMI5V2IMnfEbS+Otdiw0gKkzSl7zqQ3vX8eYsoAKA==
X-Received: by 2002:a17:902:b7c6:: with SMTP id v6-v6mr17614238plz.49.1534196900390;
        Mon, 13 Aug 2018 14:48:20 -0700 (PDT)
Received: from dsa-mb.local ([2601:282:800:fd80:fc20:f6ce:b02d:5bac])
        by smtp.googlemail.com with ESMTPSA id y63-v6sm26141867pgd.94.2018.08.13.14.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 14:48:19 -0700 (PDT)
Subject: Re: [PATCH RFC/RFT net-next 00/17] net: Convert neighbor tables to
 per-namespace
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        nikita.leshchenko@oracle.com,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Alexander Aring <alex.aring@gmail.com>,
        linux-wpan@vger.kernel.org,
        NetFilter <netfilter-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1a3f59a9-0ba5-c83f-16a6-f9550a84f693@gmail.com>
 <CAM_iQpWabZorkMNswyfHyS4KT=f_bgMtK8K35=84uah6Kfqxew@mail.gmail.com>
 <1a27e301-3275-b349-a2f8-afdfdc02f04f@gmail.com>
 <20180718.125938.2271502580775162784.davem@davemloft.net>
 <28c30574-391c-b4bd-c337-51d3040d901a@gmail.com>
 <CAM_iQpW4-JkZY7jXx0Q1b907hQ85UOL1eXv2YHwSukb5L=apUg@mail.gmail.com>
 <5021d874-8e99-6eba-f24b-4257c62d4457@gmail.com>
 <CAM_iQpUc-H2kZCBevePs6g-8qKyJkUhdd1ZDSQgYsCG0ChfC2w@mail.gmail.com>
 <87muufze8w.fsf@xmission.com>
 <4b03b5f6-87ce-9ff2-7c14-598beebd8fb8@gmail.com>
 <87zhyfw70m.fsf@xmission.com>
 <dacc9322-fd5a-dfeb-e4f1-7a288fb79886@gmail.com>
 <87o9evt9a6.fsf@xmission.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <a227d23c-40a1-97a9-d39c-70d16cd470b4@gmail.com>
Date:   Mon, 13 Aug 2018 15:48:17 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87o9evt9a6.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/18 1:17 PM, Eric W. Biederman wrote:
> David Ahern <dsahern@gmail.com> writes:
> 
>> On 7/25/18 11:38 AM, Eric W. Biederman wrote:
>>>
>>> Absolutely NOT.  Global thresholds are exactly correct given the fact
>>> you are running on a single kernel.
>>>
>>> Memory is not free (Even though we are swimming in enough of it memory
>>> rarely matters).  One of the few remaining challenges is for containers
>>> is finding was to limit resources in such a way that one application
>>> does not mess things up for another container during ordinary usage.
>>>
>>> It looks like the neighbour tables absolutely are that kind of problem,
>>> because the artificial limits are too strict.   Completely giving up on
>>> limits does not seem right approach either.  We need to fix the limits
>>> we have (perhaps making them go away entirely), not just apply a
>>> band-aid.  Let's get to the bottom of this and make the system better.
>>
>> Eric: yes, they all share the global resource of memory and there should
>> be limits on how many entries a remote entity can create.
>>
>> Network namespaces can provide a separation such that one namespace does
>> not disrupt networking in another. It is absolutely appropriate to do
>> so. Your rigid stance is inconsistent given the basic meaning of a
>> network namespace and the parallels to this same problem -- bridges,
>> vxlans, and ip fragments. Only neighbor tables are not per-device or per
>> namespace; your insistence on global limits is missing the mark and wrong.
> 
> That is not what I said.  Let me rephrase and see if you understand.
> 
> The problem appears to be of lots of devices.  Fundamentally if you use
> lots of network devices today unless you adjust gc_thresh3 you will run
> out of neighbour table entries.
> 
> The problem has a bigger scope than what you are looking at.
> 
> If you fix the core problem you won't see the problem in the context
> of network namespaces either.
> 
> Default limits should be something that will never be hit unless
> something goes crazy.  We are hitting them.  Therefore by definition
> there is a bug in these limits.

I disagree that the problem is a global limit. It is trivial for users
to increase gc_thresh3. That does not solve the fundamental problem.

> 
> 
> And yes there is absolutely a place for global limits on things like
> inodes, file descriptors etc, that does not care about which part of the
> kernel you are in.  However hitting those limits in normal operation is
> a bug.
> 
> We have ourselves a bug.

I agree we have a bug; we disagree on what that bug is.

I am just back from vacation and re-read your responses. No where do you
acknowledge the fundamental point of this patch set - that adding a new
neighbor entry in one namespace can evict an entry in another namespace
or worse networking in one namespace can fail due to table overflow
because of entries from another. That is a real problem.

It is not a matter of increasing the default gc_thresh3 to some number
N; it is ensuring that regardless of the value of gc_thresh3 one
namespace is not affected by another.

You created network namespaces and it provides isolation -- separate
tables essentially -- for devices, FIB entries, sockets, etc, but you
argue against completing the task with separate neighbor tables which is
very strange given the impact (completely broken networking).

> 
> Eric
> 
> p.s. I wrote the definition of network namespaces and it absolutely does
> have room for global limits.   One of the things Linus has periodically
> yelled at me about is that there are not enough of them.
> 
