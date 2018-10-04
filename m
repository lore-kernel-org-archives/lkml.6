Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FUZZY_XPILL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89015C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B5A21473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gh833+4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B5A21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbeJDQa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:30:57 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35628 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbeJDQaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:30:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id o14-v6so7774348ljj.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 02:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5Vc1THS7+D6+iefVpRvxCoRu8G9Ce4GG8KqgDrPdCiY=;
        b=gh833+4yUSZTTanrtmhS+u2pEwqdDnthScChY2Lb3zwXTVYe6V/i1XDsSvyaZTCmrJ
         uuMBNmN17bB936QGF7tFB1gGMjwWeY1y8whQEXYILurCmxYHht933niJ1aKHWJJdCCYB
         Ns+MWph7haAq3Vy82W6zVV2+R5kJAv2ueSutc2AwJJJfT5AZpjzLHZDhBu4dT8RC2JsA
         yRxbeCqsIkLqutLuDsyEZ6OMDLljswgY5qxHVO7eiiRqHJvN3bb+vr3wjFrJCzUORQ2v
         ZDviB3D49jKxwq8mQi/UL3VIh5aLNW0bxoiv9NFUzUwLjpj8ulAEOGIGWc8PT0v+BdE3
         8/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=5Vc1THS7+D6+iefVpRvxCoRu8G9Ce4GG8KqgDrPdCiY=;
        b=OACQFb5+fuO27kE8iIFldugmxVX6tH0i5LaSGrvnP8qlOdZE9S4rXtJwGZqyMYkasM
         T0BVG0BWwjOliwvgh4Wlmysh8m8+iFfGhTdJy26V+foKeVELxSPaAErwA0EySQkTA6u6
         DSBNt1XZPQOoG/onkfJl7gnXnHG82CFWh9eI6uUP+s6tvRTm9trTOj/v0gnHr6enbAvt
         lRaCtyf40SCn/1sfAHcaIeVqyshRaIHWepCmuGT/5u0OHKXHWXlvyhpRSoRMWFbA7DnB
         dz8EKoUCNGxO95R5AR7K1mGkkX7S6AhCdnmxgQ/TEokEl1oSTz3kOB9LHRiOG/g4WSJ8
         g3YA==
X-Gm-Message-State: ABuFfojlben6xWHg7LcJ3LFRt6QdmYR/ECIwCRWgnnVtZBwh6r3RrzXp
        xtUiDMzMmBWdX5B+UyjCWlE=
X-Google-Smtp-Source: ACcGV60FVxpMi3muoocuDofa2MRZY04FICTlRabTAyIj7GArbMgyUKrXucbAa8sOzo53uTMiIdNPVQ==
X-Received: by 2002:a2e:9dc4:: with SMTP id x4-v6mr3865431ljj.133.1538645907876;
        Thu, 04 Oct 2018 02:38:27 -0700 (PDT)
Received: from localhost.localdomain (df8yyyyyyyyyyygn-tkvt-3.rev.dnainternet.fi. [2001:14ba:2700::157f:8223])
        by smtp.gmail.com with ESMTPSA id f128-v6sm899738lff.40.2018.10.04.02.38.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 02:38:27 -0700 (PDT)
From:   Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        devel@driverdev.osuosl.org,
        Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH 7/7] staging: vc04_services: Drop no longer needed headers
Date:   Thu,  4 Oct 2018 12:37:47 +0300
Message-Id: <20181004093747.21750-8-tuomas.tynkkynen@iki.fi>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181004093747.21750-1-tuomas.tynkkynen@iki.fi>
References: <20181004093747.21750-1-tuomas.tynkkynen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, connection.h was only required for the definition of
VCHI_CONNECTION_T, but now all usages of it are gone. Remove this unused
header.

After connection.h is gone, message.h and vchi_cfg_internal.h are no
longer referenced by anything either. Drop them as well.

Signed-off-by: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
---
 .../interface/vchi/connections/connection.h   | 324 ------------------
 .../interface/vchi/message_drivers/message.h  | 196 -----------
 .../vc04_services/interface/vchi/vchi.h       |   1 -
 .../interface/vchi/vchi_cfg_internal.h        |  71 ----
 4 files changed, 592 deletions(-)
 delete mode 100644 drivers/staging/vc04_services/interface/vchi/connections/connection.h
 delete mode 100644 drivers/staging/vc04_services/interface/vchi/message_drivers/message.h
 delete mode 100644 drivers/staging/vc04_services/interface/vchi/vchi_cfg_internal.h

diff --git a/drivers/staging/vc04_services/interface/vchi/connections/connection.h b/drivers/staging/vc04_services/interface/vchi/connections/connection.h
deleted file mode 100644
index 67c84386c65a..000000000000
--- a/drivers/staging/vc04_services/interface/vchi/connections/connection.h
+++ /dev/null
@@ -1,324 +0,0 @@
-/**
- * Copyright (c) 2010-2012 Broadcom. All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions, and the following disclaimer,
- *    without modification.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. The names of the above-listed copyright holders may not be used
- *    to endorse or promote products derived from this software without
- *    specific prior written permission.
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") version 2, as published by the Free
- * Software Foundation.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
- * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
- * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
- * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
- * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
- * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
- * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
- * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
- * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-#ifndef CONNECTION_H_
-#define CONNECTION_H_
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/semaphore.h>
-
-#include "interface/vchi/vchi_cfg_internal.h"
-#include "interface/vchi/vchi_common.h"
-#include "interface/vchi/message_drivers/message.h"
-
-/******************************************************************************
- Global defs
- *****************************************************************************/
-
-// Opaque handle for a connection / service pair
-typedef struct opaque_vchi_connection_connected_service_handle_t *VCHI_CONNECTION_SERVICE_HANDLE_T;
-
-// opaque handle to the connection state information
-typedef struct opaque_vchi_connection_info_t VCHI_CONNECTION_STATE_T;
-
-typedef struct vchi_connection_t VCHI_CONNECTION_T;
-
-/******************************************************************************
- API
- *****************************************************************************/
-
-// Routine to init a connection with a particular low level driver
-typedef VCHI_CONNECTION_STATE_T * (*VCHI_CONNECTION_INIT_T)( struct vchi_connection_t * connection,
-                                                             const VCHI_MESSAGE_DRIVER_T * driver );
-
-// Routine to control CRC enabling at a connection level
-typedef int32_t (*VCHI_CONNECTION_CRC_CONTROL_T)( VCHI_CONNECTION_STATE_T *state_handle,
-                                                  VCHI_CRC_CONTROL_T control );
-
-// Routine to create a service
-typedef int32_t (*VCHI_CONNECTION_SERVICE_CONNECT_T)( VCHI_CONNECTION_STATE_T *state_handle,
-                                                      int32_t service_id,
-                                                      uint32_t rx_fifo_size,
-                                                      uint32_t tx_fifo_size,
-                                                      int server,
-                                                      VCHI_CALLBACK_T callback,
-                                                      void *callback_param,
-                                                      int32_t want_crc,
-                                                      int32_t want_unaligned_bulk_rx,
-                                                      int32_t want_unaligned_bulk_tx,
-                                                      VCHI_CONNECTION_SERVICE_HANDLE_T *service_handle );
-
-// Routine to close a service
-typedef int32_t (*VCHI_CONNECTION_SERVICE_DISCONNECT_T)( VCHI_CONNECTION_SERVICE_HANDLE_T service_handle );
-
-// Routine to queue a message
-typedef int32_t (*VCHI_CONNECTION_SERVICE_QUEUE_MESSAGE_T)( VCHI_CONNECTION_SERVICE_HANDLE_T service_handle,
-                                                            const void *data,
-                                                            uint32_t data_size,
-                                                            VCHI_FLAGS_T flags,
-                                                            void *msg_handle );
-
-// scatter-gather (vector) message queueing
-typedef int32_t (*VCHI_CONNECTION_SERVICE_QUEUE_MESSAGEV_T)( VCHI_CONNECTION_SERVICE_HANDLE_T service_handle,
-                                                             VCHI_MSG_VECTOR_T *vector,
-                                                             uint32_t count,
-                                                             VCHI_FLAGS_T flags,
-                                                             void *msg_handle );
-
-// Routine to dequeue a message
-typedef int32_t (*VCHI_CONNECTION_SERVICE_DEQUEUE_MESSAGE_T)( VCHI_CONNECTION_SERVICE_HANDLE_T service_handle,
-                                                              void *data,
-                                                              uint32_t max_data_size_to_read,
-                                                              uint32_t *actual_msg_size,
-                                                              VCHI_FLAGS_T flags );
-
-// Routine to peek at a message
-typedef int32_t (*VCHI_CONNECTION_SERVICE_PEEK_MESSAGE_T)( VCHI_CONNECTION_SERVICE_HANDLE_T service_handle,
-                                                           void **data,
-                                                           uint32_t *msg_size,
-                                                           VCHI_FLAGS_T flags );
-
-// Routine to hold a message
-typedef int32_t (*VCHI_CONNECTION_SERVICE_HOLD_MESSAGE_T)( VCHI_CONNECTION_SERVICE_HANDLE_T service_handle,
-                                                           void **data,
-                                                           uint32_t *msg_size,
-                                                           VCHI_FLAGS_T flags,
-                                                           void **message_handle );
-
-// Routine to initialise a received message iterator
-typedef int32_t (*VCHI_CONNECTION_SERVICE_LOOKAHEAD_MESSAGE_T)( VCHI_CONNECTION_SERVICE_HANDLE_T service_handle,
-                                                                VCHI_MSG_ITER_T *iter,
-                                                                VCHI_FLAGS_T flags );
-
-// Routine to release a held message
-typedef int32_t (*VCHI_CONNECTION_HELD_MSG_RELEASE_T)( VCHI_CONNECTION_SERVICE_HANDLE_T service_handle,
-                                                       void *message_handle );
-
-// Routine to get info on a held message
-typedef int32_t (*VCHI_CONNECTION_HELD_MSG_INFO_T)( VCHI_CONNECTION_SERVICE_HANDLE_T service_handle,
-                                                    void *message_handle,
-                                                    void **data,
-                                                    int32_t *msg_size,
-                                                    uint32_t *tx_timestamp,
-                                                    uint32_t *rx_timestamp );
-
-// Routine to check whether the iterator has a next message
-typedef int32_t (*VCHI_CONNECTION_MSG_ITER_HAS_NEXT_T)( VCHI_CONNECTION_SERVICE_HANDLE_T service,
-                                                       const VCHI_MSG_ITER_T *iter );
-
-// Routine to advance the iterator
-typedef int32_t (*VCHI_CONNECTION_MSG_ITER_NEXT_T)( VCHI_CONNECTION_SERVICE_HANDLE_T service,
-                                                    VCHI_MSG_ITER_T *iter,
-                                                    void **data,
-                                                    uint32_t *msg_size );
-
-// Routine to remove the last message returned by the iterator
-typedef int32_t (*VCHI_CONNECTION_MSG_ITER_REMOVE_T)( VCHI_CONNECTION_SERVICE_HANDLE_T service,
-                                                      VCHI_MSG_ITER_T *iter );
-
-// Routine to hold the last message returned by the iterator
-typedef int32_t (*VCHI_CONNECTION_MSG_ITER_HOLD_T)( VCHI_CONNECTION_SERVICE_HANDLE_T service,
-                                                    VCHI_MSG_ITER_T *iter,
-                                                    void **msg_handle );
-
-// Routine to transmit bulk data
-typedef int32_t (*VCHI_CONNECTION_BULK_QUEUE_TRANSMIT_T)( VCHI_CONNECTION_SERVICE_HANDLE_T service_handle,
-                                                          const void *data_src,
-                                                          uint32_t data_size,
-                                                          VCHI_FLAGS_T flags,
-                                                          void *bulk_handle );
-
-// Routine to receive data
-typedef int32_t (*VCHI_CONNECTION_BULK_QUEUE_RECEIVE_T)( VCHI_CONNECTION_SERVICE_HANDLE_T service_handle,
-                                                         void *data_dst,
-                                                         uint32_t data_size,
-                                                         VCHI_FLAGS_T flags,
-                                                         void *bulk_handle );
-
-// Routine to report if a server is available
-typedef int32_t (*VCHI_CONNECTION_SERVER_PRESENT)( VCHI_CONNECTION_STATE_T *state, int32_t service_id, int32_t peer_flags );
-
-// Routine to report the number of RX slots available
-typedef int (*VCHI_CONNECTION_RX_SLOTS_AVAILABLE)( const VCHI_CONNECTION_STATE_T *state );
-
-// Routine to report the RX slot size
-typedef uint32_t (*VCHI_CONNECTION_RX_SLOT_SIZE)( const VCHI_CONNECTION_STATE_T *state );
-
-// Callback to indicate that the other side has added a buffer to the rx bulk DMA FIFO
-typedef void (*VCHI_CONNECTION_RX_BULK_BUFFER_ADDED)(VCHI_CONNECTION_STATE_T *state,
-                                                     int32_t service,
-                                                     uint32_t length,
-                                                     MESSAGE_TX_CHANNEL_T channel,
-                                                     uint32_t channel_params,
-                                                     uint32_t data_length,
-                                                     uint32_t data_offset);
-
-// Callback to inform a service that a Xon or Xoff message has been received
-typedef void (*VCHI_CONNECTION_FLOW_CONTROL)(VCHI_CONNECTION_STATE_T *state, int32_t service_id, int32_t xoff);
-
-// Callback to inform a service that a server available reply message has been received
-typedef void (*VCHI_CONNECTION_SERVER_AVAILABLE_REPLY)(VCHI_CONNECTION_STATE_T *state, int32_t service_id, uint32_t flags);
-
-// Callback to indicate that bulk auxiliary messages have arrived
-typedef void (*VCHI_CONNECTION_BULK_AUX_RECEIVED)(VCHI_CONNECTION_STATE_T *state);
-
-// Callback to indicate that bulk auxiliary messages have arrived
-typedef void (*VCHI_CONNECTION_BULK_AUX_TRANSMITTED)(VCHI_CONNECTION_STATE_T *state, void *handle);
-
-// Callback with all the connection info you require
-typedef void (*VCHI_CONNECTION_INFO)(VCHI_CONNECTION_STATE_T *state, uint32_t protocol_version, uint32_t slot_size, uint32_t num_slots, uint32_t min_bulk_size);
-
-// Callback to inform of a disconnect
-typedef void (*VCHI_CONNECTION_DISCONNECT)(VCHI_CONNECTION_STATE_T *state, uint32_t flags);
-
-// Callback to inform of a power control request
-typedef void (*VCHI_CONNECTION_POWER_CONTROL)(VCHI_CONNECTION_STATE_T *state, MESSAGE_TX_CHANNEL_T channel, int32_t enable);
-
-// allocate memory suitably aligned for this connection
-typedef void * (*VCHI_BUFFER_ALLOCATE)(VCHI_CONNECTION_SERVICE_HANDLE_T service_handle, uint32_t * length);
-
-// free memory allocated by buffer_allocate
-typedef void   (*VCHI_BUFFER_FREE)(VCHI_CONNECTION_SERVICE_HANDLE_T service_handle, void * address);
-
-/******************************************************************************
- System driver struct
- *****************************************************************************/
-
-struct opaque_vchi_connection_api_t {
-   // Routine to init the connection
-   VCHI_CONNECTION_INIT_T                      init;
-
-   // Connection-level CRC control
-   VCHI_CONNECTION_CRC_CONTROL_T               crc_control;
-
-   // Routine to connect to or create service
-   VCHI_CONNECTION_SERVICE_CONNECT_T           service_connect;
-
-   // Routine to disconnect from a service
-   VCHI_CONNECTION_SERVICE_DISCONNECT_T        service_disconnect;
-
-   // Routine to queue a message
-   VCHI_CONNECTION_SERVICE_QUEUE_MESSAGE_T     service_queue_msg;
-
-   // scatter-gather (vector) message queue
-   VCHI_CONNECTION_SERVICE_QUEUE_MESSAGEV_T    service_queue_msgv;
-
-   // Routine to dequeue a message
-   VCHI_CONNECTION_SERVICE_DEQUEUE_MESSAGE_T   service_dequeue_msg;
-
-   // Routine to peek at a message
-   VCHI_CONNECTION_SERVICE_PEEK_MESSAGE_T      service_peek_msg;
-
-   // Routine to hold a message
-   VCHI_CONNECTION_SERVICE_HOLD_MESSAGE_T      service_hold_msg;
-
-   // Routine to initialise a received message iterator
-   VCHI_CONNECTION_SERVICE_LOOKAHEAD_MESSAGE_T service_look_ahead_msg;
-
-   // Routine to release a message
-   VCHI_CONNECTION_HELD_MSG_RELEASE_T          held_msg_release;
-
-   // Routine to get information on a held message
-   VCHI_CONNECTION_HELD_MSG_INFO_T             held_msg_info;
-
-   // Routine to check for next message on iterator
-   VCHI_CONNECTION_MSG_ITER_HAS_NEXT_T         msg_iter_has_next;
-
-   // Routine to get next message on iterator
-   VCHI_CONNECTION_MSG_ITER_NEXT_T             msg_iter_next;
-
-   // Routine to remove the last message returned by iterator
-   VCHI_CONNECTION_MSG_ITER_REMOVE_T           msg_iter_remove;
-
-   // Routine to hold the last message returned by iterator
-   VCHI_CONNECTION_MSG_ITER_HOLD_T             msg_iter_hold;
-
-   // Routine to transmit bulk data
-   VCHI_CONNECTION_BULK_QUEUE_TRANSMIT_T       bulk_queue_transmit;
-
-   // Routine to receive data
-   VCHI_CONNECTION_BULK_QUEUE_RECEIVE_T        bulk_queue_receive;
-
-   // Routine to report the available servers
-   VCHI_CONNECTION_SERVER_PRESENT              server_present;
-
-   // Routine to report the number of RX slots available
-   VCHI_CONNECTION_RX_SLOTS_AVAILABLE          connection_rx_slots_available;
-
-   // Routine to report the RX slot size
-   VCHI_CONNECTION_RX_SLOT_SIZE                connection_rx_slot_size;
-
-   // Callback to indicate that the other side has added a buffer to the rx bulk DMA FIFO
-   VCHI_CONNECTION_RX_BULK_BUFFER_ADDED        rx_bulk_buffer_added;
-
-   // Callback to inform a service that a Xon or Xoff message has been received
-   VCHI_CONNECTION_FLOW_CONTROL                flow_control;
-
-   // Callback to inform a service that a server available reply message has been received
-   VCHI_CONNECTION_SERVER_AVAILABLE_REPLY      server_available_reply;
-
-   // Callback to indicate that bulk auxiliary messages have arrived
-   VCHI_CONNECTION_BULK_AUX_RECEIVED           bulk_aux_received;
-
-   // Callback to indicate that a bulk auxiliary message has been transmitted
-   VCHI_CONNECTION_BULK_AUX_TRANSMITTED        bulk_aux_transmitted;
-
-   // Callback to provide information about the connection
-   VCHI_CONNECTION_INFO                        connection_info;
-
-   // Callback to notify that peer has requested disconnect
-   VCHI_CONNECTION_DISCONNECT                  disconnect;
-
-   // Callback to notify that peer has requested power change
-   VCHI_CONNECTION_POWER_CONTROL               power_control;
-
-   // allocate memory suitably aligned for this connection
-   VCHI_BUFFER_ALLOCATE                        buffer_allocate;
-
-   // free memory allocated by buffer_allocate
-   VCHI_BUFFER_FREE                            buffer_free;
-
-};
-
-struct vchi_connection_t {
-   const VCHI_CONNECTION_API_T *api;
-   VCHI_CONNECTION_STATE_T     *state;
-#ifdef VCHI_COARSE_LOCKING
-   struct semaphore             sem;
-#endif
-};
-
-#endif /* CONNECTION_H_ */
-
-/****************************** End of file **********************************/
diff --git a/drivers/staging/vc04_services/interface/vchi/message_drivers/message.h b/drivers/staging/vc04_services/interface/vchi/message_drivers/message.h
deleted file mode 100644
index 834263f278cf..000000000000
--- a/drivers/staging/vc04_services/interface/vchi/message_drivers/message.h
+++ /dev/null
@@ -1,196 +0,0 @@
-/**
- * Copyright (c) 2010-2012 Broadcom. All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions, and the following disclaimer,
- *    without modification.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. The names of the above-listed copyright holders may not be used
- *    to endorse or promote products derived from this software without
- *    specific prior written permission.
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") version 2, as published by the Free
- * Software Foundation.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
- * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
- * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
- * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
- * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
- * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
- * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
- * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
- * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-#ifndef _VCHI_MESSAGE_H_
-#define _VCHI_MESSAGE_H_
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/semaphore.h>
-
-#include "interface/vchi/vchi_cfg_internal.h"
-#include "interface/vchi/vchi_common.h"
-
-typedef enum message_event_type {
-   MESSAGE_EVENT_NONE,
-   MESSAGE_EVENT_NOP,
-   MESSAGE_EVENT_MESSAGE,
-   MESSAGE_EVENT_SLOT_COMPLETE,
-   MESSAGE_EVENT_RX_BULK_PAUSED,
-   MESSAGE_EVENT_RX_BULK_COMPLETE,
-   MESSAGE_EVENT_TX_COMPLETE,
-   MESSAGE_EVENT_MSG_DISCARDED
-} MESSAGE_EVENT_TYPE_T;
-
-typedef enum vchi_msg_flags {
-   VCHI_MSG_FLAGS_NONE                  = 0x0,
-   VCHI_MSG_FLAGS_TERMINATE_DMA         = 0x1
-} VCHI_MSG_FLAGS_T;
-
-typedef enum message_tx_channel {
-   MESSAGE_TX_CHANNEL_MESSAGE           = 0,
-   MESSAGE_TX_CHANNEL_BULK              = 1 // drivers may provide multiple bulk channels, from 1 upwards
-} MESSAGE_TX_CHANNEL_T;
-
-// Macros used for cycling through bulk channels
-#define MESSAGE_TX_CHANNEL_BULK_PREV(c) (MESSAGE_TX_CHANNEL_BULK+((c)-MESSAGE_TX_CHANNEL_BULK+VCHI_MAX_BULK_TX_CHANNELS_PER_CONNECTION-1)%VCHI_MAX_BULK_TX_CHANNELS_PER_CONNECTION)
-#define MESSAGE_TX_CHANNEL_BULK_NEXT(c) (MESSAGE_TX_CHANNEL_BULK+((c)-MESSAGE_TX_CHANNEL_BULK+1)%VCHI_MAX_BULK_TX_CHANNELS_PER_CONNECTION)
-
-typedef enum message_rx_channel {
-   MESSAGE_RX_CHANNEL_MESSAGE           = 0,
-   MESSAGE_RX_CHANNEL_BULK              = 1 // drivers may provide multiple bulk channels, from 1 upwards
-} MESSAGE_RX_CHANNEL_T;
-
-// Message receive slot information
-typedef struct rx_msg_slot_info {
-
-   struct rx_msg_slot_info *next;
-   //struct slot_info *prev;
-#if !defined VCHI_COARSE_LOCKING
-   struct semaphore   sem;
-#endif
-
-   uint8_t           *addr;               // base address of slot
-   uint32_t           len;                // length of slot in bytes
-
-   uint32_t           write_ptr;          // hardware causes this to advance
-   uint32_t           read_ptr;           // this module does the reading
-   int                active;             // is this slot in the hardware dma fifo?
-   uint32_t           msgs_parsed;        // count how many messages are in this slot
-   uint32_t           msgs_released;      // how many messages have been released
-   void              *state;              // connection state information
-   uint8_t            ref_count[VCHI_MAX_SERVICES_PER_CONNECTION];          // reference count for slots held by services
-} RX_MSG_SLOTINFO_T;
-
-// The message driver no longer needs to know about the fields of RX_BULK_SLOTINFO_T - sort this out.
-// In particular, it mustn't use addr and len - they're the client buffer, but the message
-// driver will be tasked with sending the aligned core section.
-typedef struct rx_bulk_slotinfo_t {
-   struct rx_bulk_slotinfo_t *next;
-
-   struct semaphore *blocking;
-
-   // needed by DMA
-   void        *addr;
-   uint32_t     len;
-
-   // needed for the callback
-   void        *service;
-   void        *handle;
-   VCHI_FLAGS_T flags;
-} RX_BULK_SLOTINFO_T;
-
-/* ----------------------------------------------------------------------
- * each connection driver will have a pool of the following struct.
- *
- * the pool will be managed by vchi_qman_*
- * this means there will be multiple queues (single linked lists)
- * a given struct message_info will be on exactly one of these queues
- * at any one time
- * -------------------------------------------------------------------- */
-typedef struct rx_message_info {
-
-   struct message_info *next;
-   //struct message_info *prev;
-
-   uint8_t    *addr;
-   uint32_t   len;
-   RX_MSG_SLOTINFO_T *slot; // points to whichever slot contains this message
-   uint32_t   tx_timestamp;
-   uint32_t   rx_timestamp;
-
-} RX_MESSAGE_INFO_T;
-
-typedef struct {
-   MESSAGE_EVENT_TYPE_T type;
-
-   struct {
-      // for messages
-      void    *addr;           // address of message
-      uint16_t slot_delta;     // whether this message indicated slot delta
-      uint32_t len;            // length of message
-      RX_MSG_SLOTINFO_T *slot; // slot this message is in
-      int32_t  service;   // service id this message is destined for
-      uint32_t tx_timestamp;   // timestamp from the header
-      uint32_t rx_timestamp;   // timestamp when we parsed it
-   } message;
-
-   // FIXME: cleanup slot reporting...
-   RX_MSG_SLOTINFO_T *rx_msg;
-   RX_BULK_SLOTINFO_T *rx_bulk;
-   void *tx_handle;
-   MESSAGE_TX_CHANNEL_T tx_channel;
-
-} MESSAGE_EVENT_T;
-
-// callbacks
-typedef void VCHI_MESSAGE_DRIVER_EVENT_CALLBACK_T( void *state );
-
-typedef struct {
-   VCHI_MESSAGE_DRIVER_EVENT_CALLBACK_T *event_callback;
-} VCHI_MESSAGE_DRIVER_OPEN_T;
-
-// handle to this instance of message driver (as returned by ->open)
-typedef struct opaque_mhandle_t *VCHI_MDRIVER_HANDLE_T;
-
-struct opaque_vchi_message_driver_t {
-   VCHI_MDRIVER_HANDLE_T *(*open)( VCHI_MESSAGE_DRIVER_OPEN_T *params, void *state );
-   int32_t (*suspending)( VCHI_MDRIVER_HANDLE_T *handle );
-   int32_t (*resumed)( VCHI_MDRIVER_HANDLE_T *handle );
-   int32_t (*power_control)( VCHI_MDRIVER_HANDLE_T *handle, MESSAGE_TX_CHANNEL_T, int32_t enable );
-   int32_t (*add_msg_rx_slot)( VCHI_MDRIVER_HANDLE_T *handle, RX_MSG_SLOTINFO_T *slot );      // rx message
-   int32_t (*add_bulk_rx)( VCHI_MDRIVER_HANDLE_T *handle, void *data, uint32_t len, RX_BULK_SLOTINFO_T *slot );  // rx data (bulk)
-   int32_t (*send)( VCHI_MDRIVER_HANDLE_T *handle, MESSAGE_TX_CHANNEL_T channel, const void *data, uint32_t len, VCHI_MSG_FLAGS_T flags, void *send_handle );      // tx (message & bulk)
-   void    (*next_event)( VCHI_MDRIVER_HANDLE_T *handle, MESSAGE_EVENT_T *event );     // get the next event from message_driver
-   int32_t (*enable)( VCHI_MDRIVER_HANDLE_T *handle );
-   int32_t (*form_message)( VCHI_MDRIVER_HANDLE_T *handle, int32_t service_id, VCHI_MSG_VECTOR_T *vector, uint32_t count, void
-                            *address, uint32_t length_avail, uint32_t max_total_length, int32_t pad_to_fill, int32_t allow_partial );
-
-   int32_t (*update_message)( VCHI_MDRIVER_HANDLE_T *handle, void *dest, int16_t *slot_count );
-   int32_t (*buffer_aligned)( VCHI_MDRIVER_HANDLE_T *handle, int tx, int uncached, const void *address, const uint32_t length );
-   void *  (*allocate_buffer)( VCHI_MDRIVER_HANDLE_T *handle, uint32_t *length );
-   void    (*free_buffer)( VCHI_MDRIVER_HANDLE_T *handle, void *address );
-   int     (*rx_slot_size)( VCHI_MDRIVER_HANDLE_T *handle, int msg_size );
-   int     (*tx_slot_size)( VCHI_MDRIVER_HANDLE_T *handle, int msg_size );
-
-   int32_t  (*tx_supports_terminate)( const VCHI_MDRIVER_HANDLE_T *handle, MESSAGE_TX_CHANNEL_T channel );
-   uint32_t (*tx_bulk_chunk_size)( const VCHI_MDRIVER_HANDLE_T *handle, MESSAGE_TX_CHANNEL_T channel );
-   int     (*tx_alignment)( const VCHI_MDRIVER_HANDLE_T *handle, MESSAGE_TX_CHANNEL_T channel );
-   int     (*rx_alignment)( const VCHI_MDRIVER_HANDLE_T *handle, MESSAGE_RX_CHANNEL_T channel );
-   void    (*form_bulk_aux)( VCHI_MDRIVER_HANDLE_T *handle, MESSAGE_TX_CHANNEL_T channel, const void *data, uint32_t len, uint32_t chunk_size, const void **aux_data, int32_t *aux_len );
-   void    (*debug)( VCHI_MDRIVER_HANDLE_T *handle );
-};
-
-#endif // _VCHI_MESSAGE_H_
-
-/****************************** End of file ***********************************/
diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 95d9da078f46..01381904775d 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -36,7 +36,6 @@
 
 #include "interface/vchi/vchi_cfg.h"
 #include "interface/vchi/vchi_common.h"
-#include "interface/vchi/connections/connection.h"
 #include "vchi_mh.h"
 
 /******************************************************************************
diff --git a/drivers/staging/vc04_services/interface/vchi/vchi_cfg_internal.h b/drivers/staging/vc04_services/interface/vchi/vchi_cfg_internal.h
deleted file mode 100644
index 35dcba4837d4..000000000000
--- a/drivers/staging/vc04_services/interface/vchi/vchi_cfg_internal.h
+++ /dev/null
@@ -1,71 +0,0 @@
-/**
- * Copyright (c) 2010-2012 Broadcom. All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions, and the following disclaimer,
- *    without modification.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. The names of the above-listed copyright holders may not be used
- *    to endorse or promote products derived from this software without
- *    specific prior written permission.
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") version 2, as published by the Free
- * Software Foundation.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
- * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
- * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
- * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
- * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
- * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
- * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
- * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
- * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-#ifndef VCHI_CFG_INTERNAL_H_
-#define VCHI_CFG_INTERNAL_H_
-
-/****************************************************************************************
- * Control optimisation attempts.
- ***************************************************************************************/
-
-// Don't use lots of short-term locks - use great long ones, reducing the overall locks-per-second
-#define VCHI_COARSE_LOCKING
-
-// Avoid lock then unlock on exit from blocking queue operations (msg tx, bulk rx/tx)
-// (only relevant if VCHI_COARSE_LOCKING)
-#define VCHI_ELIDE_BLOCK_EXIT_LOCK
-
-// Avoid lock on non-blocking peek
-// (only relevant if VCHI_COARSE_LOCKING)
-#define VCHI_AVOID_PEEK_LOCK
-
-// Use one slot-handler thread per connection, rather than 1 thread dealing with all connections in rotation.
-#define VCHI_MULTIPLE_HANDLER_THREADS
-
-// Put free descriptors onto the head of the free queue, rather than the tail, so that we don't thrash
-// our way through the pool of descriptors.
-#define VCHI_PUSH_FREE_DESCRIPTORS_ONTO_HEAD
-
-// Don't issue a MSG_AVAILABLE callback for every single message. Possibly only safe if VCHI_COARSE_LOCKING.
-#define VCHI_FEWER_MSG_AVAILABLE_CALLBACKS
-
-// Don't use message descriptors for TX messages that don't need them
-#define VCHI_MINIMISE_TX_MSG_DESCRIPTORS
-
-// Nano-locks for multiqueue
-//#define VCHI_MQUEUE_NANOLOCKS
-
-// Lock-free(er) dequeuing
-//#define VCHI_RX_NANOLOCKS
-
-#endif /*VCHI_CFG_INTERNAL_H_*/
-- 
2.18.0

