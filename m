Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753645AbeFATTT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 15:19:19 -0400
Received: from mailrelay1-1.pub.mailoutpod1-cph3.one.com ([46.30.210.182]:61293
        "EHLO mailrelay1-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753383AbeFATTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 15:19:16 -0400
X-HalOne-Cookie: 121addfac42c3cd53c6ff6b48e91901f7f2d53a7
X-HalOne-ID: 6d9c663c-65ce-11e8-8fa3-d0431ea8a283
Subject: Re: [PATCH 1/2] HID: multitouch: report MT_TOOL_PALM for
 non-confident touches
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jason Gerecke <killertofu@gmail.com>,
        Dennis Kempin <denniskempin@google.com>,
        Andrew de los Reyes <adlr@google.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20170811004500.13740-1-dmitry.torokhov@gmail.com>
 <CAO-hwJJ8E4mQqu0RYaZrmawud4wbSVE4GHEvg7oxUzEc-B5nvQ@mail.gmail.com>
 <20180601184330.GD222005@dtor-ws>
From: Henrik Rydberg <rydberg@bitmath.org>
Message-ID: <72b7120a-d304-0b2f-d04a-473631623f72@bitmath.org>
Date: Fri, 1 Jun 2018 21:03:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180601184330.GD222005@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> However, I interpret a firmware that send (confidence 1, tip switch 1)
>> and then (confidence 0, tip switch 0) a simple release, and the
>> confidence bit should not be relayed.
> This unfortunately leads to false clicks: you start with finger, so
> confidence is 1, then you transition the same touch to palm (use your
> thumb and "roll" your hand until heel of it comes into contact with the
> screen). The firmware reports "no-confidence" and "release" in the same
> report and userspace seeing release does not pay attention to confidence
> (i.e. it does exactly "simple release" logic) and this results in UI
> interpreting this as a click. With splitting no-confidence
> (MT_TOOL_PALM) and release event into separate frames we help userspace
> to recognize that the contact should be discarded.
This is in part why I objected to this patch on August 11th, 2017. 
Logically, the confidence state is a property of a contact, not a new 
type of contact. Trying to use it in any other way is bound to lead to 
confusion.

Henrik
