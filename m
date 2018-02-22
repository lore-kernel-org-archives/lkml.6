Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751330AbeBVS6s (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 13:58:48 -0500
Received: from smtp1.it.da.ut.ee ([193.40.5.66]:33768 "EHLO smtp1.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751158AbeBVS6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 13:58:46 -0500
Date: Thu, 22 Feb 2018 20:58:41 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: esc.storagedev@microsemi.com
cc: linux-scsi@vger.kernel.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: hpsa crashes on boot in 4.16-rc2-00062
Message-ID: <alpine.LRH.2.21.1802222043240.9192@math.ut.ee>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This happens on a HP DL360 G6 with Smart Array 410i.

Will try to bisect.

IO completion timeout could be because of some IRQ toubles?

(sorry, the rest has scrolled away in ilo2 textcons)

[  242.655025] Call Trace:                                                      
[  242.655077]  ? __schedule+0x1dd/0x5e0                                        
[  242.655130]  schedule+0x23/0x70                                              
[  242.655182]  schedule_timeout+0xe1/0x290                                     
[  242.655236]  io_schedule_timeout+0x14/0x40                                   
[  242.655290]  wait_for_completion_io+0xa4/0x120                               
[  242.655346]  ? wake_up_q+0x70/0x70                                           
[  242.655401]  hpsa_scsi_do_simple_cmd+0xa7/0xf0                               
[  242.655456]  hpsa_scsi_do_simple_cmd_with_retry+0x4a/0x150                   
[  242.655512]  hpsa_scsi_do_inquiry+0x5d/0xc0                                  
[  242.655567]  hpsa_scan_start+0xf67/0x1fa0                                    
[  242.655621]  ? sched_clock_local+0x12/0x80                                   
[  242.655675]  ? sched_clock_local+0x12/0x80                                   
[  242.655729]  ? select_idle_sibling+0x21/0x3b0                                
[  242.655785]  ? do_scsi_scan_host+0x2d/0x90                                   
[  242.655839]  do_scsi_scan_host+0x2d/0x90                                     
[  242.655892]  do_scan_async+0x12/0x180                                        
[  242.655945]  async_run_entry_fn+0x2c/0x140                                   
[  242.656002]  process_one_work+0x1a6/0x320                                    
[  242.656062]  worker_thread+0x26/0x3c0                                        
[  242.656115]  ? create_worker+0x190/0x190                                     
[  242.656170]  kthread+0x107/0x120                                             
[  242.656222]  ? kthread_create_worker_on_cpu+0x70/0x70                        
[  242.656278]  ret_from_fork+0x35/0x40  


-- 
Meelis Roos (mroos@linux.ee)
