Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751647AbeA3LcM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 06:32:12 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32802 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751475AbeA3LcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 06:32:11 -0500
X-Google-Smtp-Source: AH8x227/8N0pSNGyNB8NVHBz1o1oFA4GzsCZubVBK5ITV+04McU1L3lmUY6HlXxzLLv+H8ypiayauQ==
Date: Tue, 30 Jan 2018 12:32:08 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: chenchacha <chen.chenchacha@foxmail.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 3/3] fs: fat: add ioctl method in fat filesystem driver
Message-ID: <20180130113208.glmvabsx54yth5dl@pali>
References: <20180117104355.889-1-chen.chenchacha@foxmail.com>
 <20180117104355.889-4-chen.chenchacha@foxmail.com>
 <87r2q8n7gs.fsf@mail.parknet.co.jp>
 <0464dacb-b8f1-4bb2-3e05-e5f35ebf6e8e@foxmail.com>
 <87bmhbmvzc.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bmhbmvzc.fsf@mail.parknet.co.jp>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 January 2018 20:23:03 OGAWA Hirofumi wrote:
> chenchacha <chen.chenchacha@foxmail.com> writes:
> 
> > On 01/29/2018 09:02 PM, OGAWA Hirofumi wrote:
> >> ChenGuanqiao <chen.chenchacha@foxmail.com> writes:
> >>
> >>> +static int fat_check_d_characters(char *label, unsigned long len)
> >>> +{
> >>> +	int i;
> >>> +
> >>> +	for (i = 0; i < len; ++i) {
> >>> +		switch (label[i]) {
> >>> +		case 'a' ... 'z':
> >>> +			label[i] = __toupper(label[i]);
> >>> +		case 'A' ... 'Z':
> >>> +		case '0' ... '9':
> >>> +		case '_':
> >>> +		case 0x20:
> >>> +			continue;
> >>> +		default:
> >>> +			return -EINVAL;
> >>> +		}
> >> Same question with previous though, what windows do if label = "a b c"?
> >> (this is including space other than end of name or extension.)
> > In win7, the volume label will be capitalized, and leaving spaces.
> > Or, you mean I need to fill the rest of the space with "0x20"?
> 
> I see. However, what win7 stored, BTW? It was "A B C      ", or anything
> other?

Yes, as in FAT, all directory entries are padded by spaces.

-- 
Pali Rohár
pali.rohar@gmail.com
