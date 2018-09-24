Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D060ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D2E2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uy51YimT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D2E2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733160AbeIXXbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:31:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40415 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731112AbeIXXbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:31:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id y8-v6so16888375wrh.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bS6DDfR72CcfKEY37sG21U3PNOQzS17+wStQesfKHtE=;
        b=uy51YimTkA0/I8XqQMIKBcef1etljrgSeEfDF5V7tzJKj4EMl2DGMQFG7a4KJqhX3X
         eKkqmscMsKDLCRs3wUky/NNOBvQPly7cCgrPWn7SU6jMZ4wC1qpuYwoc+TbbFMQ00zOn
         1+lRRy16Fmd9X+LcXrWqP6LA1GwIlORNx5+ngsVDU4pB8P5pLLEYiRg7FjfqwsmI+Mci
         KRil9IxqOpVALv2wczkuNNtn/xkTN3eTCVWJfemr+7AxKEyQanbSRFMhnxpGlIuzbEk3
         HDSkv0fsinfBG737SuNZ4ka0nWqFHezG8SsaxuyoHVPOr/A6pSx1Hhi0CQrdZSwwwZlq
         2XLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bS6DDfR72CcfKEY37sG21U3PNOQzS17+wStQesfKHtE=;
        b=sjFZ4njsGU3Tu0JKL88oZNnSmM6T30KxZaQvQBC/kgQRX5nRXHhYDOUqQs2m6EKHwV
         /PtQ/ZlNUNSwo846UnKeh/gFP2BSbJkei8Eo7mkCChI2Kl/98n/47bb/IGqk79jGAgvB
         e4wNwGKQfqRHPTXUCOKhO+18dzq8NMIcPhrLU3IbOiYAYccVj++yeuChZNwyiE7se4zG
         qi0QbvtR42DKKtqaoPsHXtm4loiIim4i0gE7/F6BO/b0mRLuN3ihJQi4spBk10z5nLN7
         B//MNrMl0ebJs2FCJ8T1M+NKjUCTgoUqk0twTUF7gI+4fzBIPRcYAgNarAbAn4XmJhO5
         qJMg==
X-Gm-Message-State: ABuFfogSK2xCvmFRLOn306r7j0/qNCycyMX2LqdaaJjwTltMueSJXoUO
        6gBHczff40Zmn6hqAklvxCI=
X-Google-Smtp-Source: ACcGV60EIEiqjoWp4L4Hv5zYnojiCauvtrkGQkB2i6N8Bmh5MriuWm2/eOJgp52WXOl391tXpKUW/w==
X-Received: by 2002:adf:b189:: with SMTP id q9-v6mr10199138wra.95.1537810107716;
        Mon, 24 Sep 2018 10:28:27 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:c])
        by smtp.gmail.com with ESMTPSA id y206-v6sm15998258wmg.14.2018.09.24.10.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 10:28:27 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
Cc:     Aymen Qader <qader.aymen@gmail.com>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] staging: vc04_services: Fix "space prohibited"
Date:   Mon, 24 Sep 2018 18:27:40 +0100
Message-Id: <20180924172743.21153-2-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180924172743.21153-1-qader.aymen@gmail.com>
References: <20180923140620.14583-1-qader.aymen@gmail.com>
 <20180924172743.21153-1-qader.aymen@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl error:

ERROR: space prohibited after/before that open/closed parenthesis

in the interface/vchi directory.

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 .../vc04_services/interface/vchi/vchi.h       | 106 +++++++++---------
 .../vc04_services/interface/vchi/vchi_cfg.h   |   2 +-
 2 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 66a3a060fad2..ffb8caaacaea 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -98,7 +98,7 @@ typedef struct vchi_msg_vector_ex {
 #define VCHI_VEC_HANDLE(h,o,l) VCHI_VEC_HANDLE,  { { (h), (o), (l) } }
 
 // Macros to manipulate 'FOURCC' values
-#define MAKE_FOURCC(x) ((int32_t)( (x[0] << 24) | (x[1] << 16) | (x[2] << 8) | x[3] ))
+#define MAKE_FOURCC(x) ((int32_t)((x[0] << 24) | (x[1] << 16) | (x[2] << 8) | x[3]))
 #define FOURCC_TO_CHAR(x) (x >> 24) & 0xFF,(x >> 16) & 0xFF,(x >> 8) & 0xFF, x & 0xFF
 
 // Opaque service information
@@ -154,25 +154,25 @@ typedef struct service_info_tag {
 extern "C" {
 #endif
 
-extern /*@observer@*/ VCHI_CONNECTION_T * vchi_create_connection( const VCHI_CONNECTION_API_T * function_table,
+extern /*@observer@*/ VCHI_CONNECTION_T * vchi_create_connection(const VCHI_CONNECTION_API_T * function_table,
                                                    const VCHI_MESSAGE_DRIVER_T * low_level);
 
 // Routine used to initialise the vchi on both local + remote connections
-extern int32_t vchi_initialise( VCHI_INSTANCE_T *instance_handle );
+extern int32_t vchi_initialise(VCHI_INSTANCE_T *instance_handle);
 
-extern int32_t vchi_exit( void );
+extern int32_t vchi_exit(void);
 
-extern int32_t vchi_connect( VCHI_CONNECTION_T **connections,
+extern int32_t vchi_connect(VCHI_CONNECTION_T **connections,
                              const uint32_t num_connections,
-                             VCHI_INSTANCE_T instance_handle );
+                             VCHI_INSTANCE_T instance_handle);
 
 //When this is called, ensure that all services have no data pending.
 //Bulk transfers can remain 'queued'
-extern int32_t vchi_disconnect( VCHI_INSTANCE_T instance_handle );
+extern int32_t vchi_disconnect(VCHI_INSTANCE_T instance_handle);
 
 // Global control over bulk CRC checking
-extern int32_t vchi_crc_control( VCHI_CONNECTION_T *connection,
-                                 VCHI_CRC_CONTROL_T control );
+extern int32_t vchi_crc_control(VCHI_CONNECTION_T *connection,
+                                 VCHI_CRC_CONTROL_T control);
 
 // helper functions
 extern void * vchi_allocate_buffer(VCHI_SERVICE_HANDLE_T handle, uint32_t *length);
@@ -183,32 +183,32 @@ extern uint32_t vchi_current_time(VCHI_INSTANCE_T instance_handle);
  Global service API
  *****************************************************************************/
 // Routine to create a named service
-extern int32_t vchi_service_create( VCHI_INSTANCE_T instance_handle,
+extern int32_t vchi_service_create(VCHI_INSTANCE_T instance_handle,
                                     SERVICE_CREATION_T *setup,
-                                    VCHI_SERVICE_HANDLE_T *handle );
+                                    VCHI_SERVICE_HANDLE_T *handle);
 
 // Routine to destroy a service
-extern int32_t vchi_service_destroy( const VCHI_SERVICE_HANDLE_T handle );
+extern int32_t vchi_service_destroy(const VCHI_SERVICE_HANDLE_T handle);
 
 // Routine to open a named service
-extern int32_t vchi_service_open( VCHI_INSTANCE_T instance_handle,
+extern int32_t vchi_service_open(VCHI_INSTANCE_T instance_handle,
                                   SERVICE_CREATION_T *setup,
                                   VCHI_SERVICE_HANDLE_T *handle);
 
-extern int32_t vchi_get_peer_version( const VCHI_SERVICE_HANDLE_T handle,
-                                      short *peer_version );
+extern int32_t vchi_get_peer_version(const VCHI_SERVICE_HANDLE_T handle,
+                                      short *peer_version);
 
 // Routine to close a named service
-extern int32_t vchi_service_close( const VCHI_SERVICE_HANDLE_T handle );
+extern int32_t vchi_service_close(const VCHI_SERVICE_HANDLE_T handle);
 
 // Routine to increment ref count on a named service
-extern int32_t vchi_service_use( const VCHI_SERVICE_HANDLE_T handle );
+extern int32_t vchi_service_use(const VCHI_SERVICE_HANDLE_T handle);
 
 // Routine to decrement ref count on a named service
-extern int32_t vchi_service_release( const VCHI_SERVICE_HANDLE_T handle );
+extern int32_t vchi_service_release(const VCHI_SERVICE_HANDLE_T handle);
 
 // Routine to set a control option for a named service
-extern int32_t vchi_service_set_option( const VCHI_SERVICE_HANDLE_T handle,
+extern int32_t vchi_service_set_option(const VCHI_SERVICE_HANDLE_T handle,
 					VCHI_SERVICE_OPTION_T option,
 					int value);
 
@@ -226,128 +226,128 @@ vchi_queue_user_message(VCHI_SERVICE_HANDLE_T handle,
 
 // Routine to receive a msg from a service
 // Dequeue is equivalent to hold, copy into client buffer, release
-extern int32_t vchi_msg_dequeue( VCHI_SERVICE_HANDLE_T handle,
+extern int32_t vchi_msg_dequeue(VCHI_SERVICE_HANDLE_T handle,
                                  void *data,
                                  uint32_t max_data_size_to_read,
                                  uint32_t *actual_msg_size,
-                                 VCHI_FLAGS_T flags );
+                                 VCHI_FLAGS_T flags);
 
 // Routine to look at a message in place.
 // The message is not dequeued, so a subsequent call to peek or dequeue
 // will return the same message.
-extern int32_t vchi_msg_peek( VCHI_SERVICE_HANDLE_T handle,
+extern int32_t vchi_msg_peek(VCHI_SERVICE_HANDLE_T handle,
                               void **data,
                               uint32_t *msg_size,
-                              VCHI_FLAGS_T flags );
+                              VCHI_FLAGS_T flags);
 
 // Routine to remove a message after it has been read in place with peek
 // The first message on the queue is dequeued.
-extern int32_t vchi_msg_remove( VCHI_SERVICE_HANDLE_T handle );
+extern int32_t vchi_msg_remove(VCHI_SERVICE_HANDLE_T handle);
 
 // Routine to look at a message in place.
 // The message is dequeued, so the caller is left holding it; the descriptor is
 // filled in and must be released when the user has finished with the message.
-extern int32_t vchi_msg_hold( VCHI_SERVICE_HANDLE_T handle,
+extern int32_t vchi_msg_hold(VCHI_SERVICE_HANDLE_T handle,
                               void **data,        // } may be NULL, as info can be
                               uint32_t *msg_size, // } obtained from HELD_MSG_T
                               VCHI_FLAGS_T flags,
-                              VCHI_HELD_MSG_T *message_descriptor );
+                              VCHI_HELD_MSG_T *message_descriptor);
 
 // Initialise an iterator to look through messages in place
-extern int32_t vchi_msg_look_ahead( VCHI_SERVICE_HANDLE_T handle,
+extern int32_t vchi_msg_look_ahead(VCHI_SERVICE_HANDLE_T handle,
                                     VCHI_MSG_ITER_T *iter,
-                                    VCHI_FLAGS_T flags );
+                                    VCHI_FLAGS_T flags);
 
 /******************************************************************************
  Global service support API - operations on held messages and message iterators
  *****************************************************************************/
 
 // Routine to get the address of a held message
-extern void *vchi_held_msg_ptr( const VCHI_HELD_MSG_T *message );
+extern void *vchi_held_msg_ptr(const VCHI_HELD_MSG_T *message);
 
 // Routine to get the size of a held message
-extern int32_t vchi_held_msg_size( const VCHI_HELD_MSG_T *message );
+extern int32_t vchi_held_msg_size(const VCHI_HELD_MSG_T *message);
 
 // Routine to get the transmit timestamp as written into the header by the peer
-extern uint32_t vchi_held_msg_tx_timestamp( const VCHI_HELD_MSG_T *message );
+extern uint32_t vchi_held_msg_tx_timestamp(const VCHI_HELD_MSG_T *message);
 
 // Routine to get the reception timestamp, written as we parsed the header
-extern uint32_t vchi_held_msg_rx_timestamp( const VCHI_HELD_MSG_T *message );
+extern uint32_t vchi_held_msg_rx_timestamp(const VCHI_HELD_MSG_T *message);
 
 // Routine to release a held message after it has been processed
-extern int32_t vchi_held_msg_release( VCHI_HELD_MSG_T *message );
+extern int32_t vchi_held_msg_release(VCHI_HELD_MSG_T *message);
 
 // Indicates whether the iterator has a next message.
-extern int32_t vchi_msg_iter_has_next( const VCHI_MSG_ITER_T *iter );
+extern int32_t vchi_msg_iter_has_next(const VCHI_MSG_ITER_T *iter);
 
 // Return the pointer and length for the next message and advance the iterator.
-extern int32_t vchi_msg_iter_next( VCHI_MSG_ITER_T *iter,
+extern int32_t vchi_msg_iter_next(VCHI_MSG_ITER_T *iter,
                                    void **data,
-                                   uint32_t *msg_size );
+                                   uint32_t *msg_size);
 
 // Remove the last message returned by vchi_msg_iter_next.
 // Can only be called once after each call to vchi_msg_iter_next.
-extern int32_t vchi_msg_iter_remove( VCHI_MSG_ITER_T *iter );
+extern int32_t vchi_msg_iter_remove(VCHI_MSG_ITER_T *iter);
 
 // Hold the last message returned by vchi_msg_iter_next.
 // Can only be called once after each call to vchi_msg_iter_next.
-extern int32_t vchi_msg_iter_hold( VCHI_MSG_ITER_T *iter,
-                                   VCHI_HELD_MSG_T *message );
+extern int32_t vchi_msg_iter_hold(VCHI_MSG_ITER_T *iter,
+                                   VCHI_HELD_MSG_T *message);
 
 // Return information for the next message, and hold it, advancing the iterator.
-extern int32_t vchi_msg_iter_hold_next( VCHI_MSG_ITER_T *iter,
+extern int32_t vchi_msg_iter_hold_next(VCHI_MSG_ITER_T *iter,
                                         void **data,        // } may be NULL
                                         uint32_t *msg_size, // }
-                                        VCHI_HELD_MSG_T *message );
+                                        VCHI_HELD_MSG_T *message);
 
 /******************************************************************************
  Global bulk API
  *****************************************************************************/
 
 // Routine to prepare interface for a transfer from the other side
-extern int32_t vchi_bulk_queue_receive( VCHI_SERVICE_HANDLE_T handle,
+extern int32_t vchi_bulk_queue_receive(VCHI_SERVICE_HANDLE_T handle,
                                         void *data_dst,
                                         uint32_t data_size,
                                         VCHI_FLAGS_T flags,
-                                        void *transfer_handle );
+                                        void *transfer_handle);
 
 // Prepare interface for a transfer from the other side into relocatable memory.
-int32_t vchi_bulk_queue_receive_reloc( const VCHI_SERVICE_HANDLE_T handle,
+int32_t vchi_bulk_queue_receive_reloc(const VCHI_SERVICE_HANDLE_T handle,
                                        VCHI_MEM_HANDLE_T h_dst,
                                        uint32_t offset,
                                        uint32_t data_size,
                                        const VCHI_FLAGS_T flags,
-                                       void * const bulk_handle );
+                                       void * const bulk_handle);
 
 // Routine to queue up data ready for transfer to the other (once they have signalled they are ready)
-extern int32_t vchi_bulk_queue_transmit( VCHI_SERVICE_HANDLE_T handle,
+extern int32_t vchi_bulk_queue_transmit(VCHI_SERVICE_HANDLE_T handle,
                                          const void *data_src,
                                          uint32_t data_size,
                                          VCHI_FLAGS_T flags,
-                                         void *transfer_handle );
+                                         void *transfer_handle);
 
 /******************************************************************************
  Configuration plumbing
  *****************************************************************************/
 
 // function prototypes for the different mid layers (the state info gives the different physical connections)
-extern const VCHI_CONNECTION_API_T *single_get_func_table( void );
-//extern const VCHI_CONNECTION_API_T *local_server_get_func_table( void );
-//extern const VCHI_CONNECTION_API_T *local_client_get_func_table( void );
+extern const VCHI_CONNECTION_API_T *single_get_func_table(void);
+//extern const VCHI_CONNECTION_API_T *local_server_get_func_table(void);
+//extern const VCHI_CONNECTION_API_T *local_client_get_func_table(void);
 
 // declare all message drivers here
-const VCHI_MESSAGE_DRIVER_T *vchi_mphi_message_driver_func_table( void );
+const VCHI_MESSAGE_DRIVER_T *vchi_mphi_message_driver_func_table(void);
 
 #ifdef __cplusplus
 }
 #endif
 
-extern int32_t vchi_bulk_queue_transmit_reloc( VCHI_SERVICE_HANDLE_T handle,
+extern int32_t vchi_bulk_queue_transmit_reloc(VCHI_SERVICE_HANDLE_T handle,
                                                VCHI_MEM_HANDLE_T h_src,
                                                uint32_t offset,
                                                uint32_t data_size,
                                                VCHI_FLAGS_T flags,
-                                               void *transfer_handle );
+                                               void *transfer_handle);
 #endif /* VCHI_H_ */
 
 /****************************** End of file **********************************/
diff --git a/drivers/staging/vc04_services/interface/vchi/vchi_cfg.h b/drivers/staging/vc04_services/interface/vchi/vchi_cfg.h
index b6f42b86f206..0d3c468c3504 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi_cfg.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi_cfg.h
@@ -138,7 +138,7 @@
  * can guarantee this by enabling unaligned transmits).
  * Not API. */
 #ifndef VCHI_MIN_BULK_SIZE
-#  define VCHI_MIN_BULK_SIZE    ( VCHI_MAX_MSG_SIZE / 2 < 4096 ? VCHI_MAX_MSG_SIZE / 2 : 4096 )
+#  define VCHI_MIN_BULK_SIZE    (VCHI_MAX_MSG_SIZE / 2 < 4096 ? VCHI_MAX_MSG_SIZE / 2 : 4096)
 #endif
 
 /* Maximum size of bulk transmission chunks, for each interface type. A trade-off between
-- 
2.17.1

