Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709AEC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BC520652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13BC520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754776AbeFTJF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:05:59 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34141 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754295AbeFTJFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:05:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id l15-v6so21882805wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 02:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=SqTODgPo3waitAi9yIo8IC54mjgWUSq51SaLrTJt4lc=;
        b=dMzk4HboYTsPn1kXoK2qgHQVfA759Y/A/l/tZVETl+efigdy9uJ9SknfIcWj73Ltcx
         PEGprSJj0yz3maMx53Aloifd8C/oEhIwZJEIIwcWNfDW6S5sb0FsP0ZBaA+rIKVkrPDz
         AKtIAfkMOq/QbhsiYT1JYu4ctIT7jcI18A401gLlFcLxnsvi1sKjU3hkgBibPYa/CanR
         iQn5w/DDf/+gBNrE1kB9GyAAyuik8LqqjBo3gDWuZ10lo/SZeFpRy/0IwurSr7KmcuEQ
         rw8NJimR/D7pN0seBHNq5FTkRoVmtFe3/Kqjl0EswkkZqSbwdgm0lhZY5WZXpOSLHoF0
         6ucg==
X-Gm-Message-State: APt69E22vLkRHr/dOXoGf3L9XU0fgN9zC63twsnU1u2MgOXqpTxHTVMd
        eOeQ/4hM0jfU97MtbMwc9zGj7p4IrYk=
X-Google-Smtp-Source: ADUXVKIQBi/NKMbaGvQ37RZ1IomZG4Pymdbith9esWSn7TbaYEKaeNtoEbGoanM0JCJK0ZdekI2Tbg==
X-Received: by 2002:aa7:d819:: with SMTP id v25-v6mr17917853edq.61.1529478370538;
        Wed, 20 Jun 2018 00:06:10 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id 2-v6sm933022edz.67.2018.06.20.00.06.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 00:06:09 -0700 (PDT)
Subject: Re: [GIT PULL] HID fixes
To:     Julian Sax <jsbc@gmx.de>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <nycvar.YFH.7.76.1806191356280.6203@cbobk.fhfr.pm>
 <CA+55aFx1o8+ZTAqVQNH7Wq8tm90XYTUEx5By2wWo3KJDR3g2MQ@mail.gmail.com>
 <nycvar.YFH.7.76.1806200611290.6203@cbobk.fhfr.pm>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b952c1f6-5866-d25e-32c2-ac0ded1812e2@redhat.com>
Date:   Wed, 20 Jun 2018 09:06:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.1806200611290.6203@cbobk.fhfr.pm>
Content-Type: multipart/mixed;
 boundary="------------5E145726BE739AE5A221C679"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5E145726BE739AE5A221C679
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

On 20-06-18 06:19, Jiri Kosina wrote:
> On Wed, 20 Jun 2018, Linus Torvalds wrote:
> 
>> What is that odd binary blob i2c_hid_desc_override, and where does the
>> data come from? Not explained anywhere.
> 
> Fair enough; it's a pretty standard HID descriptor override, but you're
> right that we're usually replacing it in a bit more verbose way. Julian,
> could you please run that descriptor through something like HID descriptor
> tool, and send me a patch that reformats it? (for the way we usually do
> this, look for example in hid-sony.c).

Julian let me know if you need any help with this,
to format the HID descriptor take a file with
the raw descriptor in binary format and do:

cat descriptor.bin | hidrd-convert -o code

I've just done that to make sure my instructions are
right, so to save you having to redo this I've
attached the result.

Regards,

Hans



--------------5E145726BE739AE5A221C679
Content-Type: text/x-csrc;
 name="desc.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="desc.c"

0x05, 0x01,                     /*  Usage Page (Desktop),                   */
0x09, 0x02,                     /*  Usage (Mouse),                          */
0xA1, 0x01,                     /*  Collection (Application),               */
0x85, 0x01,                     /*      Report ID (1),                      */
0x09, 0x01,                     /*      Usage (Pointer),                    */
0xA1, 0x00,                     /*      Collection (Physical),              */
0x05, 0x09,                     /*          Usage Page (Button),            */
0x19, 0x01,                     /*          Usage Minimum (01h),            */
0x29, 0x02,                     /*          Usage Maximum (02h),            */
0x25, 0x01,                     /*          Logical Maximum (1),            */
0x75, 0x01,                     /*          Report Size (1),                */
0x95, 0x02,                     /*          Report Count (2),               */
0x81, 0x02,                     /*          Input (Variable),               */
0x95, 0x06,                     /*          Report Count (6),               */
0x81, 0x01,                     /*          Input (Constant),               */
0x05, 0x01,                     /*          Usage Page (Desktop),           */
0x09, 0x30,                     /*          Usage (X),                      */
0x09, 0x31,                     /*          Usage (Y),                      */
0x15, 0x81,                     /*          Logical Minimum (-127),         */
0x25, 0x7F,                     /*          Logical Maximum (127),          */
0x75, 0x08,                     /*          Report Size (8),                */
0x95, 0x02,                     /*          Report Count (2),               */
0x81, 0x06,                     /*          Input (Variable, Relative),     */
0xC0,                           /*      End Collection,                     */
0xC0,                           /*  End Collection,                         */
0x05, 0x0D,                     /*  Usage Page (Digitizer),                 */
0x09, 0x05,                     /*  Usage (Touchpad),                       */
0xA1, 0x01,                     /*  Collection (Application),               */
0x85, 0x04,                     /*      Report ID (4),                      */
0x05, 0x0D,                     /*      Usage Page (Digitizer),             */
0x09, 0x22,                     /*      Usage (Finger),                     */
0xA1, 0x02,                     /*      Collection (Logical),               */
0x15, 0x00,                     /*          Logical Minimum (0),            */
0x25, 0x01,                     /*          Logical Maximum (1),            */
0x09, 0x47,                     /*          Usage (Touch Valid),            */
0x09, 0x42,                     /*          Usage (Tip Switch),             */
0x95, 0x02,                     /*          Report Count (2),               */
0x75, 0x01,                     /*          Report Size (1),                */
0x81, 0x02,                     /*          Input (Variable),               */
0x95, 0x01,                     /*          Report Count (1),               */
0x75, 0x03,                     /*          Report Size (3),                */
0x25, 0x05,                     /*          Logical Maximum (5),            */
0x09, 0x51,                     /*          Usage (Contact Identifier),     */
0x81, 0x02,                     /*          Input (Variable),               */
0x75, 0x01,                     /*          Report Size (1),                */
0x95, 0x03,                     /*          Report Count (3),               */
0x81, 0x03,                     /*          Input (Constant, Variable),     */
0x05, 0x01,                     /*          Usage Page (Desktop),           */
0x26, 0x44, 0x0A,               /*          Logical Maximum (2628),         */
0x75, 0x10,                     /*          Report Size (16),               */
0x55, 0x0E,                     /*          Unit Exponent (14),             */
0x65, 0x11,                     /*          Unit (Centimeter),              */
0x09, 0x30,                     /*          Usage (X),                      */
0x46, 0x1A, 0x04,               /*          Physical Maximum (1050),        */
0x95, 0x01,                     /*          Report Count (1),               */
0x81, 0x02,                     /*          Input (Variable),               */
0x46, 0xBC, 0x02,               /*          Physical Maximum (700),         */
0x26, 0x34, 0x05,               /*          Logical Maximum (1332),         */
0x09, 0x31,                     /*          Usage (Y),                      */
0x81, 0x02,                     /*          Input (Variable),               */
0xC0,                           /*      End Collection,                     */
0x05, 0x0D,                     /*      Usage Page (Digitizer),             */
0x09, 0x22,                     /*      Usage (Finger),                     */
0xA1, 0x02,                     /*      Collection (Logical),               */
0x25, 0x01,                     /*          Logical Maximum (1),            */
0x09, 0x47,                     /*          Usage (Touch Valid),            */
0x09, 0x42,                     /*          Usage (Tip Switch),             */
0x95, 0x02,                     /*          Report Count (2),               */
0x75, 0x01,                     /*          Report Size (1),                */
0x81, 0x02,                     /*          Input (Variable),               */
0x95, 0x01,                     /*          Report Count (1),               */
0x75, 0x03,                     /*          Report Size (3),                */
0x25, 0x05,                     /*          Logical Maximum (5),            */
0x09, 0x51,                     /*          Usage (Contact Identifier),     */
0x81, 0x02,                     /*          Input (Variable),               */
0x75, 0x01,                     /*          Report Size (1),                */
0x95, 0x03,                     /*          Report Count (3),               */
0x81, 0x03,                     /*          Input (Constant, Variable),     */
0x05, 0x01,                     /*          Usage Page (Desktop),           */
0x26, 0x44, 0x0A,               /*          Logical Maximum (2628),         */
0x75, 0x10,                     /*          Report Size (16),               */
0x09, 0x30,                     /*          Usage (X),                      */
0x46, 0x1A, 0x04,               /*          Physical Maximum (1050),        */
0x95, 0x01,                     /*          Report Count (1),               */
0x81, 0x02,                     /*          Input (Variable),               */
0x46, 0xBC, 0x02,               /*          Physical Maximum (700),         */
0x26, 0x34, 0x05,               /*          Logical Maximum (1332),         */
0x09, 0x31,                     /*          Usage (Y),                      */
0x81, 0x02,                     /*          Input (Variable),               */
0xC0,                           /*      End Collection,                     */
0x05, 0x0D,                     /*      Usage Page (Digitizer),             */
0x09, 0x22,                     /*      Usage (Finger),                     */
0xA1, 0x02,                     /*      Collection (Logical),               */
0x25, 0x01,                     /*          Logical Maximum (1),            */
0x09, 0x47,                     /*          Usage (Touch Valid),            */
0x09, 0x42,                     /*          Usage (Tip Switch),             */
0x95, 0x02,                     /*          Report Count (2),               */
0x75, 0x01,                     /*          Report Size (1),                */
0x81, 0x02,                     /*          Input (Variable),               */
0x95, 0x01,                     /*          Report Count (1),               */
0x75, 0x03,                     /*          Report Size (3),                */
0x25, 0x05,                     /*          Logical Maximum (5),            */
0x09, 0x51,                     /*          Usage (Contact Identifier),     */
0x81, 0x02,                     /*          Input (Variable),               */
0x75, 0x01,                     /*          Report Size (1),                */
0x95, 0x03,                     /*          Report Count (3),               */
0x81, 0x03,                     /*          Input (Constant, Variable),     */
0x05, 0x01,                     /*          Usage Page (Desktop),           */
0x26, 0x44, 0x0A,               /*          Logical Maximum (2628),         */
0x75, 0x10,                     /*          Report Size (16),               */
0x09, 0x30,                     /*          Usage (X),                      */
0x46, 0x1A, 0x04,               /*          Physical Maximum (1050),        */
0x95, 0x01,                     /*          Report Count (1),               */
0x81, 0x02,                     /*          Input (Variable),               */
0x46, 0xBC, 0x02,               /*          Physical Maximum (700),         */
0x26, 0x34, 0x05,               /*          Logical Maximum (1332),         */
0x09, 0x31,                     /*          Usage (Y),                      */
0x81, 0x02,                     /*          Input (Variable),               */
0xC0,                           /*      End Collection,                     */
0x05, 0x0D,                     /*      Usage Page (Digitizer),             */
0x09, 0x22,                     /*      Usage (Finger),                     */
0xA1, 0x02,                     /*      Collection (Logical),               */
0x25, 0x01,                     /*          Logical Maximum (1),            */
0x09, 0x47,                     /*          Usage (Touch Valid),            */
0x09, 0x42,                     /*          Usage (Tip Switch),             */
0x95, 0x02,                     /*          Report Count (2),               */
0x75, 0x01,                     /*          Report Size (1),                */
0x81, 0x02,                     /*          Input (Variable),               */
0x95, 0x01,                     /*          Report Count (1),               */
0x75, 0x03,                     /*          Report Size (3),                */
0x25, 0x05,                     /*          Logical Maximum (5),            */
0x09, 0x51,                     /*          Usage (Contact Identifier),     */
0x81, 0x02,                     /*          Input (Variable),               */
0x75, 0x01,                     /*          Report Size (1),                */
0x95, 0x03,                     /*          Report Count (3),               */
0x81, 0x03,                     /*          Input (Constant, Variable),     */
0x05, 0x01,                     /*          Usage Page (Desktop),           */
0x26, 0x44, 0x0A,               /*          Logical Maximum (2628),         */
0x75, 0x10,                     /*          Report Size (16),               */
0x09, 0x30,                     /*          Usage (X),                      */
0x46, 0x1A, 0x04,               /*          Physical Maximum (1050),        */
0x95, 0x01,                     /*          Report Count (1),               */
0x81, 0x02,                     /*          Input (Variable),               */
0x46, 0xBC, 0x02,               /*          Physical Maximum (700),         */
0x26, 0x34, 0x05,               /*          Logical Maximum (1332),         */
0x09, 0x31,                     /*          Usage (Y),                      */
0x81, 0x02,                     /*          Input (Variable),               */
0xC0,                           /*      End Collection,                     */
0x05, 0x0D,                     /*      Usage Page (Digitizer),             */
0x55, 0x0C,                     /*      Unit Exponent (12),                 */
0x66, 0x01, 0x10,               /*      Unit (Seconds),                     */
0x47, 0xFF, 0xFF, 0x00, 0x00,   /*      Physical Maximum (65535),           */
0x27, 0xFF, 0xFF, 0x00, 0x00,   /*      Logical Maximum (65535),            */
0x75, 0x10,                     /*      Report Size (16),                   */
0x95, 0x01,                     /*      Report Count (1),                   */
0x09, 0x56,                     /*      Usage (Scan Time),                  */
0x81, 0x02,                     /*      Input (Variable),                   */
0x09, 0x54,                     /*      Usage (Contact Count),              */
0x25, 0x7F,                     /*      Logical Maximum (127),              */
0x75, 0x08,                     /*      Report Size (8),                    */
0x81, 0x02,                     /*      Input (Variable),                   */
0x05, 0x09,                     /*      Usage Page (Button),                */
0x09, 0x01,                     /*      Usage (01h),                        */
0x25, 0x01,                     /*      Logical Maximum (1),                */
0x75, 0x01,                     /*      Report Size (1),                    */
0x95, 0x01,                     /*      Report Count (1),                   */
0x81, 0x02,                     /*      Input (Variable),                   */
0x95, 0x07,                     /*      Report Count (7),                   */
0x81, 0x03,                     /*      Input (Constant, Variable),         */
0x05, 0x0D,                     /*      Usage Page (Digitizer),             */
0x85, 0x02,                     /*      Report ID (2),                      */
0x09, 0x55,                     /*      Usage (Contact Count Maximum),      */
0x09, 0x59,                     /*      Usage (59h),                        */
0x75, 0x04,                     /*      Report Size (4),                    */
0x95, 0x02,                     /*      Report Count (2),                   */
0x25, 0x0F,                     /*      Logical Maximum (15),               */
0xB1, 0x02,                     /*      Feature (Variable),                 */
0x05, 0x0D,                     /*      Usage Page (Digitizer),             */
0x85, 0x07,                     /*      Report ID (7),                      */
0x09, 0x60,                     /*      Usage (60h),                        */
0x75, 0x01,                     /*      Report Size (1),                    */
0x95, 0x01,                     /*      Report Count (1),                   */
0x25, 0x01,                     /*      Logical Maximum (1),                */
0xB1, 0x02,                     /*      Feature (Variable),                 */
0x95, 0x07,                     /*      Report Count (7),                   */
0xB1, 0x03,                     /*      Feature (Constant, Variable),       */
0x85, 0x06,                     /*      Report ID (6),                      */
0x06, 0x00, 0xFF,               /*      Usage Page (FF00h),                 */
0x09, 0xC5,                     /*      Usage (C5h),                        */
0x26, 0xFF, 0x00,               /*      Logical Maximum (255),              */
0x75, 0x08,                     /*      Report Size (8),                    */
0x96, 0x00, 0x01,               /*      Report Count (256),                 */
0xB1, 0x02,                     /*      Feature (Variable),                 */
0xC0,                           /*  End Collection,                         */
0x06, 0x00, 0xFF,               /*  Usage Page (FF00h),                     */
0x09, 0x01,                     /*  Usage (01h),                            */
0xA1, 0x01,                     /*  Collection (Application),               */
0x85, 0x0D,                     /*      Report ID (13),                     */
0x26, 0xFF, 0x00,               /*      Logical Maximum (255),              */
0x19, 0x01,                     /*      Usage Minimum (01h),                */
0x29, 0x02,                     /*      Usage Maximum (02h),                */
0x75, 0x08,                     /*      Report Size (8),                    */
0x95, 0x02,                     /*      Report Count (2),                   */
0xB1, 0x02,                     /*      Feature (Variable),                 */
0xC0,                           /*  End Collection,                         */
0x05, 0x0D,                     /*  Usage Page (Digitizer),                 */
0x09, 0x0E,                     /*  Usage (Configuration),                  */
0xA1, 0x01,                     /*  Collection (Application),               */
0x85, 0x03,                     /*      Report ID (3),                      */
0x09, 0x22,                     /*      Usage (Finger),                     */
0xA1, 0x02,                     /*      Collection (Logical),               */
0x09, 0x52,                     /*          Usage (Device Mode),            */
0x25, 0x0A,                     /*          Logical Maximum (10),           */
0x95, 0x01,                     /*          Report Count (1),               */
0xB1, 0x02,                     /*          Feature (Variable),             */
0xC0,                           /*      End Collection,                     */
0x09, 0x22,                     /*      Usage (Finger),                     */
0xA1, 0x00,                     /*      Collection (Physical),              */
0x85, 0x05,                     /*          Report ID (5),                  */
0x09, 0x57,                     /*          Usage (57h),                    */
0x09, 0x58,                     /*          Usage (58h),                    */
0x75, 0x01,                     /*          Report Size (1),                */
0x95, 0x02,                     /*          Report Count (2),               */
0x25, 0x01,                     /*          Logical Maximum (1),            */
0xB1, 0x02,                     /*          Feature (Variable),             */
0x95, 0x06,                     /*          Report Count (6),               */
0xB1, 0x03,                     /*          Feature (Constant, Variable),   */
0xC0,                           /*      End Collection,                     */
0xC0                            /*  End Collection                          */

--------------5E145726BE739AE5A221C679--
