Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754333AbeEHGcv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 02:32:51 -0400
Received: from mail-pl0-f52.google.com ([209.85.160.52]:46707 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754308AbeEHGct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 02:32:49 -0400
X-Google-Smtp-Source: AB8JxZqkx0nDxZZhbaLBoZE3jWpwFkG7gWZ72TkdKHgxwTmTGzwiYv0ag+jjDGS2/DIG7o4XKkI+tw==
Subject: Re: [PATCH 0/3] scsi: arcmsr: Add driver parameter cmd_timeout for
 scsi command timeout setting
From: Ching Huang <ching2048@areca.com.tw>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: James.Bottomley@HansenPartnership.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.carpenter@oracle.com,
        hch@infradead.org, colin.king@canonical.com
In-Reply-To: <yq1in7ywvo8.fsf@oracle.com>
References: <1525675401.8876.9.camel@Centos6.3-64>
         <yq1in7ywvo8.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 08 May 2018 14:32:46 +0800
Message-ID: <1525761166.4261.8.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-05-08 at 01:41 -0400, Martin K. Petersen wrote:
> Hello Ching,
> 
> > 1. Add driver parameter cmd_timeout, default value is ARCMSR_DEFAULT_TIMEOUT.
> > 2. Add slave_configure callback function to set device command timeout value.
> > 3. Update driver version to v1.40.00.06-20180504.
> 
> I am not so keen on arcmsr overriding the timeout set by the admin or
> application.
> 
> Also, instead of introducing this module parameter, why not simply ask
> the user to change rq_timeout?
> 
This timeout setting only after device has been inquiry successfully.
Of course, user can set timeout value to /sys/block/sdX/device/timeout.
But user does not like to set this value once command timeout occurred.
They rather like timeout never happen.
