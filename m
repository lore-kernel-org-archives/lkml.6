Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2962962-1527015585-2-2866192448389161911
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527015584; b=L2KhlStvQpVPjur/VR6oCkQq6yRcUT+MSCOfB494EIJQGNyIil
    dzKQ/tSrdiYMEfjAMtn8MbaKOwcoy01VP8OSAP9l5eNOGRbcyYMOYWf8jAOLWb9W
    GZLyzOfeZigsVapDt81iG6oGDq1evinF91Gy5JBOyg7ztOYtZBsH2GgFXLUIf1j3
    BuaoDVvKcqQQe/Jltw3Iu5HJnj+MMpQxWp/Lc+U8RvEi3/Wp5TQU77vnLLsx26P5
    iUd4HmdzFXB5LjYdlOqsb7V4untmnRZNp7L2QDCjR3thaHBJ65aNLb+orFNQJeNY
    GBQxvGx5GR13KvrJaYKcoHHM7os9mLA/197w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527015584; bh=LRxXvg5j+HVC/8QcYAEwPgfKI99MnoaCNm7aG/W0iz
    w=; b=fV88ZlrPinTvDYwF9oYY3AEkkdiDG/CMbo045lCMZaSFrdgrD52yCd9nUT
    Mk8+t7YsCWoqI2SMMyUxz6XYB3wI56Ivf0dj6wgT4ECIxgCPQOw6rK0a7H3pjQ54
    7qoAIuuFyyaZKW6iCZTTQASzTieDnluQ3w8/tb46NE6ALFbZOurTNcFbyLgXW7Yc
    XAbXUzesKEo+wWNnkL7za6EP1iXNNLLP0qZKJvShd9u9+Wki6W6TWo2Z5nMJlFpD
    oad5oR+yPvtG2eVQ4nrZYNhbdXnFUyp+IK1PZMG/i9o5PTfUDwwTBzs6+7UTFM6T
    U1TUh5AQ4L4h1MQjJpMa9yrV/dQA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=paul-moore-com.20150623.gappssmtp.com
    header.i=@paul-moore-com.20150623.gappssmtp.com header.b=jjmc9qQZ
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Wu2oRLsB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=paul-moore.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=paul-moore-com.20150623.gappssmtp.com
      header.i=@paul-moore-com.20150623.gappssmtp.com header.b=jjmc9qQZ
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Wu2oRLsB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=paul-moore.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN02D/QmyLBGxGt8z1JogyyrCw8lxtJj7rTyVQSXuKbCES2Xv8NbflFtADKQqPW08Cd/MIyqd2Nvbi9lNzr7E3uWuayA9xrI1jbfj6MkAIHd0scmYK1O
    Qmbaer5joGbPWRLuwE2mnqEujk6DLNOpphS4dTatifUXrBfUsBVwywhz96pa073/tmUO2LSyKBk320BmKXjfoeASUqKDKjFn50pzMxG/E6tp17F9eE6bmDRL
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EmDd13E5pkEA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8 a=PtDNVHqPAAAA:8 a=xVhDTqbCAAAA:8
    a=VwQbUJbxAAAA:8 a=wHtQran_GHA2FCfVCPkA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=BpimnaHY1jUKGyF_4-AF:22 a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeEVS7m (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 14:59:42 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39156 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751713AbeEVS7k (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 14:59:40 -0400
X-Google-Smtp-Source: AB8JxZphcWSkENMP110fP/XIPCekBE+ibbxHi2nqeIr0uG4Xoc5J6VgKSobd9jAVVYvDTOHY948mWb3z3OoYZfffn9o=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180522173541.slcdszumi7q6c4id@madcap2.tricolour.ca>
References: <cover.1521179281.git.rgb@redhat.com> <1081821010c124fe4e35984ec3dac1654453bb7c.1521179281.git.rgb@redhat.com>
 <3001737.MkQ41rgtZF@x2> <87muwshl4z.fsf@xmission.com> <CAHC9VhQruN88t-R9Qo3e4hwCZ58RAyrmEmH1nY4RR6NZaiBzGQ@mail.gmail.com>
 <20180522173541.slcdszumi7q6c4id@madcap2.tricolour.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 22 May 2018 14:59:38 -0400
Message-ID: <CAHC9VhS_jMHv4g_A6kPWohOU0LNJ5-ntcf7Xu_xEv6NTXu3yyw@mail.gmail.com>
Subject: Re: [RFC PATCH ghak32 V2 13/13] debug audit: read container ID of a process
To: Richard Guy Briggs <rgb@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Steve Grubb <sgrubb@redhat.com>, simo@redhat.com,
        jlayton@redhat.com, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>, dhowells@redhat.com,
        carlos@redhat.com, linux-audit@redhat.com, viro@zeniv.linux.org.uk,
        luto@kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 22, 2018 at 1:35 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-05-21 16:06, Paul Moore wrote:
>> On Mon, May 21, 2018 at 3:19 PM, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> > Steve Grubb <sgrubb@redhat.com> writes:
>> >> On Friday, March 16, 2018 5:00:40 AM EDT Richard Guy Briggs wrote:
>> >>> Add support for reading the container ID from the proc filesystem.
>> >>
>> >> I think this could be useful in general. Please consider this to be part of
>> >> the full patch set and not something merely used to debug the patches.
>> >
>> > Only with an audit specific name.
>> >
>> > As it is:
>> >
>> > Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> >
>> > The truth is the containerid name really stinks and is quite confusing
>> > and does not imply that the label applies only to audit.  And little
>> > things like this make me extremely uncofortable with it.
>>
>> It also makes the audit container ID (notice how I *always* call it
>> the *audit* container ID? that is not an accident) available for
>> userspace applications to abuse.  Perhaps in the future we can look at
>> ways to make this more available to applications, but this patch is
>> not the answer.
>
> Do you have a productive suggestion?

I haven't given it much thought beyond our discussions and until we
get the basic audit container ID support in place (all the other parts
of this patchset) I doubt I'll be giving it much thought.

-- 
paul moore
www.paul-moore.com
