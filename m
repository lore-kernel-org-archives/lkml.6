Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751145AbeBJPwi (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 10:52:38 -0500
Received: from mout.gmx.net ([212.227.17.22]:46447 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751057AbeBJPwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 10:52:37 -0500
To: linux-kernel@vger.kernel.org
From: "Enrico Weigelt, metux IT consult" <metux@gmx.de>
Subject: RFC: build config via DT names
Message-ID: <63f25fea-f163-f9cc-b5b2-f6f291d7f8d2@gmx.de>
Date: Sat, 10 Feb 2018 16:52:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:8w19Jnvj63bApZPEWE9jrNcsOkwVo0WdXTa5FQj8o2O8vsBCTJ/
 9BtFlE8ZDTSQOBEFtM2D1z55XlZESwo0CkzY3CnqjoFlz8QGqR5FiVhvsSE60HCWDgeKHjY
 cHk5+oIuDNNi2tTlL4w2Y38vmTxv9v30RciJoYP8SMq/1zKBfTzPIdt1xgb9e5sicbz+DBg
 /gZtqXVN6fXtJh038Nvqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7+XLaibq2RA=:NY6efBkSPp3MY4VMkruSm+
 CKv4k7auMQGlVNanMGc5mvVx9yewNAizWVEXNx1e2p7ZZ5zdIm3RmP2McdOhbo9RzU2czgv0r
 bGYPBw100GMWivo+PNEkIN/vIY0gald9MibEuHFIW9qA2IMDewWoXWFIbTXzzaDA62+fupvLZ
 7I5zI0/iEp4rCXckDQIgSFN2fLd8l0FeGq8flOyTBiwuWchtbS9J47WQGHA1Zcx8U9zikwjGr
 I0S+szxfsz3dZ0hfjVpOAQcKr3d0oQXFuetV9pZq1hLk0MpmWMdU2WpzoKDvGPlCM89NpHc2W
 dYEZrDISbQ8HyoD3goChPdTTVgyQIG9b55XdjBPyk06JpTdVeqJ9JOieODD+vaRup+xcMFwuR
 GE0NQxu/Hr5n6KgXPiNDwp7jlO172P64sxqjB7NJVrlraoCvS+yvMqR5uUjL5ui1mo7k5V9+c
 x/ncpM69RscPRH/DuOrjdJ4WcDHI3Yr7qQBCbIeSXPmSK6jgRDoXFi4SwO7hgt/il7QJKMuy7
 PjIHhqr1zg85fnJ3VTN0d7keZSm/dXUASmIOqvAhOQqEBidLN89o3UoOnKIHYRcgGCUnJV4Z6
 gc0rW39O0N0CvegqMBpIBvzrUqcJDi2bp97xNVuf3RWscMLWfFsgkMmPUhcQzZvALQOphBOX3
 0bmcysfuGJXrhZttCLu2Sz8FYFM+qMWp1zCbP51HFiMOz5it/HWh5iU2o2kbsQ8sXK9CfwpzU
 2qz5hnfK1wFxc/xGQmHZfHDa3LvkAZ5wHqIj1ORek695cSmpHQ9NzWZ7gQefMEysmRdtRAVtu
 PpYA+K7p79adYg2p97UV+LPPwQvFroi+2+/+i0dAxl8U4TpGE8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I've regularily have the task of configuring a kernel for a given DT.
To make this a little bit easier, I'd like to do this automatically.

The tuff task here is getting a mapping between dt compatible strings
and corresponding CONFIG_* flags. Automatically extracting it from the
source code seems pretty tricky, especially w/ corner cases (eg. some
drivers support groups of devices, depending on config options) - IMHO
it will need some code changes anyways.

Therefore I propose a simple approach using the existing Kconfig system:

Add an extra (toplevel) menu and config flag naming scheme which
directly map DT compatible strings to config flags. For example:

 > fsl,mpc5200-gpio <=> CONFIG_DTDEV_FSL_MPC5200_GPIO

 > config CONFIG_DTDEV_FSL_MPC5200_GPIO
 >    tristate "fsl,mpc5200-gpio"
 >    select GPIO_MPC5200

Note that these flags are separate from the actual drivers - they just
enable them automatically. Of course they'll have to be maintained by
the driver maintainers.


What do you think about this idea ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
